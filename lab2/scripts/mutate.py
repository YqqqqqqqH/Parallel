#!/usr/bin/env python3
"""变异测试：生成每个变异体，用 xsim 实测，与 tb_model.py 的预测逐项比对。

阶段一（官方激励 + tb_monitor，不中途停止）：实测 first_fail 和 fail_ns，要求与
results/predictions.csv 精确相等，结果写 results/mutation.csv。
阶段二（--plus，增强激励 alu_tb_plus）：正确设计应 0 错误，每个变异体应被杀死，
记录各类向量的出错数，结果写 results/mutation_plus.csv。
"""
import argparse
import csv
import re
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import mutants  # noqa: E402
import xsim     # noqa: E402

LAB = Path(__file__).resolve().parent.parent
BUILD = LAB / "build" / "mutants"
RESULTS = LAB / "results"


def build_all():
    BUILD.mkdir(parents=True, exist_ok=True)
    src = (LAB / "src" / "alu.v").read_text()
    paths = {}
    for mid, fid, _ in mutants.MUTANTS:
        p = BUILD / f"alu_{fid}.v"
        p.write_text(mutants.apply(fid, src))
        paths[fid] = p
    return paths


def official(paths, jobs):
    pred = {r["file_id"]: r for r in csv.DictReader(open(RESULTS / "predictions.csv"))}
    with ThreadPoolExecutor(jobs) as ex:
        res = dict(zip(paths, ex.map(lambda kv: xsim.run(f"mut_{kv[0]}", kv[1]), paths.items())))
    rows, ok = [], True
    for mid, fid, desc in mutants.MUTANTS:
        r, p = res[fid], pred[fid]
        match = r.get("first_fail") == int(p["first_fail_ns"]) and r.get("fail_ns") == int(p["fail_ns"])
        ok &= match
        rows.append({"id": mid, "desc": desc,
                     "pred_first_fail": p["first_fail_ns"], "xsim_first_fail": r.get("first_fail"),
                     "pred_fail_ns": p["fail_ns"], "xsim_fail_ns": r.get("fail_ns"),
                     "match": "是" if match else "否", "xsim_first_vector": r.get("first_vector", ""),
                     "seconds": r["seconds"]})
        print(f"{mid:4} 预测 {p['first_fail_ns']:>8}/{p['fail_ns']:>7}  xsim {r.get('first_fail'):>8}/"
              f"{r.get('fail_ns'):>7}  {'一致' if match else '不一致'}  {r.get('first_vector', '')}")
    with open(RESULTS / "mutation.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]))
        w.writeheader()
        w.writerows(rows)
    print("全部一致" if ok else "存在不一致，需要追查")
    return ok


def plus(paths, jobs):
    designs = {"correct": LAB / "src" / "alu.v", **paths}
    with ThreadPoolExecutor(jobs) as ex:
        res = dict(zip(designs, ex.map(lambda kv: xsim.run(f"plus_{kv[0]}", kv[1], plus=True),
                                       designs.items())))
    names = {"correct": "正确设计", **{fid: mid for mid, fid, _ in mutants.MUTANTS}}
    rows = []
    for key, r in res.items():
        out = r["output"]
        cls = {m.group(1): int(m.group(2)) for m in re.finditer(r"PLUS class=(\S+) errors=(\d+)", out)}
        tot = re.search(r"PLUS_TOTAL vectors=(\d+) errors=(\d+)", out)
        row = {"design": names[key], "vectors": tot.group(1) if tot else "",
               "errors": tot.group(2) if tot else "", **cls}
        rows.append(row)
        print(f"{names[key]:6} 错误 {row['errors']:>6} / {row['vectors']}  " +
              "  ".join(f"{k}={v}" for k, v in cls.items()))
    fields = list(dict.fromkeys(k for row in rows for k in row))
    with open(RESULTS / "mutation_plus.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fields, restval=0)
        w.writeheader()
        w.writerows(rows)
    good = rows[0]["errors"] == "0" and all(int(r["errors"] or 0) > 0 for r in rows[1:])
    print("增强激励：正确设计 0 错误、变异体全部被杀" if good else "增强激励结果不符合预期")
    return good


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--plus", action="store_true", help="跑增强激励（阶段二）")
    ap.add_argument("-j", "--jobs", type=int, default=4)
    a = ap.parse_args()
    paths = build_all()
    return 0 if (plus(paths, a.jobs) if a.plus else official(paths, a.jobs)) else 1


if __name__ == "__main__":
    sys.exit(main())
