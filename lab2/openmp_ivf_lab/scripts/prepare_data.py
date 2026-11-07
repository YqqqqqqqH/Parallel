#!/usr/bin/env python3
"""从公开 SIFT1M（texmex）自建本实验所需的 5 个数据文件，并写出 MANIFEST。

课程提供的 /var/dataset 在本机不可用，因此按课程文件的格式自行生成：
  sift_base.fbin         1,000,000 × 128 float32（由 sift_base.fvecs 转换）
  sift_query.fbin        10,000 × 128 float32（由 sift_query.fvecs 转换）
  centroid_4096.fvecs    faiss IndexIVFFlat 在全部库向量上训练得到的 4096 个中心
  cluster_id_4096.ivecs  每个库向量所属列表（quantizer 最近中心），N 行 × 1
  gt.ibin                每个查询按 (距离, 编号) 升序的前 1000 个精确近邻

用法：
  python -I scripts/prepare_data.py --raw ~/datasets/sift1m/raw/sift --out ~/datasets/sift1m
"""

import argparse
import hashlib
import json
import os
import platform
import sys
import time

import faiss
import numpy as np

NLIST = 4096
GT_K = 1000


def read_vecs(path, dtype):
    raw = np.fromfile(path, dtype=np.int32)
    dim = int(raw[0])
    rows = raw.size // (dim + 1)
    if rows * (dim + 1) != raw.size:
        raise ValueError(f"{path}: 文件大小不是整行")
    mat = raw.reshape(rows, dim + 1)
    if not np.all(mat[:, 0] == dim):
        raise ValueError(f"{path}: 行维数不一致")
    return np.ascontiguousarray(mat[:, 1:]).view(dtype)


def write_bin(path, mat):
    rows, dim = mat.shape
    with open(path, "wb") as f:
        np.array([rows, dim], dtype=np.uint32).tofile(f)
        np.ascontiguousarray(mat).tofile(f)


def write_vecs(path, mat):
    rows, dim = mat.shape
    out = np.empty((rows, dim + 1), dtype=np.int32)
    out[:, 0] = dim
    out[:, 1:] = np.ascontiguousarray(mat).view(np.int32)
    out.tofile(path)


def md5(path):
    h = hashlib.md5()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 22), b""):
            h.update(chunk)
    return h.hexdigest()


def check_integer_coords(name, x):
    """事实 ② 的前提：坐标都是非负小整数。"""
    is_int = bool(np.all(x == np.round(x)))
    lo, hi = float(x.min()), float(x.max())
    print(f"{name}: 整数坐标={is_int} 取值范围=[{lo:g}, {hi:g}]")
    if not is_int:
        raise ValueError(f"{name} 含非整数坐标，float32 精确距离的前提不成立")
    return {"integer": is_int, "min": lo, "max": hi}


def exact_sqdist(xb_i16, xq_i16, ids):
    """用整数精确重算 ids[q, j] 与查询 q 的平方距离（int64）。"""
    out = np.empty(ids.shape, dtype=np.int64)
    step = 200
    for s in range(0, ids.shape[0], step):
        cand = xb_i16[ids[s:s + step]].astype(np.int32)          # (b, m, d)
        diff = cand - xq_i16[s:s + step, None, :].astype(np.int32)
        out[s:s + step] = np.einsum("bmd,bmd->bm", diff, diff, dtype=np.int64)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--raw", required=True, help="解压后的 sift/ 目录")
    ap.add_argument("--out", required=True, help="输出目录")
    args = ap.parse_args()
    raw = os.path.expanduser(args.raw)
    out = os.path.expanduser(args.out)
    os.makedirs(out, exist_ok=True)
    manifest = {"source": "ftp://ftp.irisa.fr/local/texmex/corpus/sift.tar.gz",
                "python": sys.version.split()[0], "faiss": faiss.__version__,
                "numpy": np.__version__, "host": platform.platform()}

    # 1. 读取并检查原始数据
    xb = read_vecs(os.path.join(raw, "sift_base.fvecs"), np.float32)
    xq = read_vecs(os.path.join(raw, "sift_query.fvecs"), np.float32)
    gt_public = read_vecs(os.path.join(raw, "sift_groundtruth.ivecs"), np.int32)
    print(f"base {xb.shape}  query {xq.shape}  public gt {gt_public.shape}")
    manifest["coords"] = {"base": check_integer_coords("base", xb),
                          "query": check_integer_coords("query", xq)}
    span = max(manifest["coords"]["base"]["max"], manifest["coords"]["query"]["max"]) - \
        min(manifest["coords"]["base"]["min"], manifest["coords"]["query"]["min"])
    bound = xb.shape[1] * span * span
    manifest["coords"]["max_sqdist_bound"] = bound
    manifest["coords"]["bound_below_2^24"] = bool(bound < 2 ** 24)
    print(f"距离上界 d*M^2 = {bound:.0f}，小于 2^24={bound < 2 ** 24}")

    # 2. 转换为 fbin
    write_bin(os.path.join(out, "sift_base.fbin"), xb)
    write_bin(os.path.join(out, "sift_query.fbin"), xq)

    # 3. 训练 IVF4096（全部库向量）并分配列表
    d = xb.shape[1]
    quantizer = faiss.IndexFlatL2(d)
    ivf = faiss.IndexIVFFlat(quantizer, d, NLIST)
    cp = ivf.cp
    manifest["train"] = {"index": "IndexIVFFlat(IndexFlatL2, 128, 4096)",
                         "train_set": "sift_base (全部 1,000,000 个向量)",
                         "niter": cp.niter, "seed": cp.seed, "nredo": cp.nredo,
                         "max_points_per_centroid": cp.max_points_per_centroid,
                         "min_points_per_centroid": cp.min_points_per_centroid,
                         "faiss_omp_threads": faiss.omp_get_max_threads()}
    t0 = time.time()
    ivf.train(xb)
    manifest["train"]["seconds"] = round(time.time() - t0, 1)
    print(f"训练完成：{manifest['train']}")
    centroids = quantizer.reconstruct_n(0, NLIST).astype(np.float32)
    _, assign = quantizer.search(xb, 1)
    assign = assign[:, 0].astype(np.int32)
    write_vecs(os.path.join(out, f"centroid_{NLIST}.fvecs"), centroids)
    write_vecs(os.path.join(out, f"cluster_id_{NLIST}.ivecs"), assign[:, None])
    sizes = np.bincount(assign, minlength=NLIST)
    manifest["lists"] = {"min": int(sizes.min()), "median": float(np.median(sizes)),
                         "mean": float(sizes.mean()), "max": int(sizes.max()),
                         "empty": int((sizes == 0).sum()),
                         "p99": float(np.percentile(sizes, 99))}
    print(f"列表长度：{manifest['lists']}")

    # 4. 精确 ground truth：faiss 取前 GT_K+1，再用整数距离按 (距离, 编号) 重排
    t0 = time.time()
    flat = faiss.IndexFlatL2(d)
    flat.add(xb)
    fdist, ids = flat.search(xq, GT_K + 1)
    xb_i16 = xb.astype(np.int16)
    xq_i16 = xq.astype(np.int16)
    dist = exact_sqdist(xb_i16, xq_i16, ids)
    float_err = np.abs(fdist.astype(np.float64) - dist).max()
    order = np.lexsort((ids, dist), axis=-1)
    ids_sorted = np.take_along_axis(ids, order, axis=-1)
    dist_sorted = np.take_along_axis(dist, order, axis=-1)
    boundary_tie = int((dist_sorted[:, GT_K - 1] == dist_sorted[:, GT_K]).sum())
    gt = np.ascontiguousarray(ids_sorted[:, :GT_K]).astype(np.int32)
    write_bin(os.path.join(out, "gt.ibin"), gt)
    manifest["gt"] = {"k": GT_K, "seconds": round(time.time() - t0, 1),
                      "faiss_float_vs_exact_max_abs_err": float(float_err),
                      "queries_with_tie_at_rank_1000_1001": boundary_tie}
    print(f"gt：{manifest['gt']}")

    # 5. 与公开 gt（前 100）交叉核对：差异只允许出现在等距处
    k_pub = gt_public.shape[1]
    same_order = int(np.all(gt[:, :k_pub] == gt_public, axis=1).sum())
    set_diff, unexplained = 0, 0
    for q in range(gt.shape[0]):
        ours, pub = set(gt[q, :k_pub].tolist()), set(gt_public[q].tolist())
        if ours != pub:
            set_diff += 1
            kth = dist_sorted[q, k_pub - 1]
            extra = np.array(sorted(pub - ours), dtype=np.int64)
            dpub = exact_sqdist(xb_i16, xq_i16[q:q + 1], extra[None, :])[0]
            if not np.all(dpub == kth):
                unexplained += 1
    manifest["gt_vs_public_top100"] = {"identical_order": same_order,
                                       "set_differs": set_diff,
                                       "set_differs_not_explained_by_tie": unexplained}
    print(f"与公开 gt 比较：{manifest['gt_vs_public_top100']}")
    if unexplained:
        raise SystemExit("自建 gt 与公开 gt 存在非等距差异，停止")

    # 6. 文件校验和
    manifest["files"] = {}
    for name in ["sift_base.fbin", "sift_query.fbin", f"centroid_{NLIST}.fvecs",
                 f"cluster_id_{NLIST}.ivecs", "gt.ibin"]:
        path = os.path.join(out, name)
        manifest["files"][name] = {"bytes": os.path.getsize(path), "md5": md5(path)}
    with open(os.path.join(out, "MANIFEST.json"), "w", encoding="utf-8") as f:
        json.dump(manifest, f, ensure_ascii=False, indent=2)
    print(json.dumps(manifest["files"], indent=2))


if __name__ == "__main__":
    main()
