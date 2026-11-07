#!/usr/bin/env bash
# 各脚本共用：数据路径（默认是自建数据目录，可用 IVF_DATA 覆盖，例如 IVF_DATA=/var/dataset）
IVF_DATA="${IVF_DATA:-/home/felix/datasets/sift1m}"
DATA_ARGS=(--base "$IVF_DATA/sift_base.fbin" --centroids "$IVF_DATA/centroid_4096.fvecs"
           --cluster-ids "$IVF_DATA/cluster_id_4096.ivecs" --queries-file "$IVF_DATA/sift_query.fbin"
           --gt "$IVF_DATA/gt.ibin")
