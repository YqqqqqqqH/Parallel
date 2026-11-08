#!/usr/bin/env bash
# 各脚本共用：数据路径（默认是课程服务器上的官方数据 /var/dataset，可用 IVF_DATA 覆盖）
IVF_DATA="${IVF_DATA:-/var/dataset}"
DATA_ARGS=(--base "$IVF_DATA/sift_base.fbin" --centroids "$IVF_DATA/centroid_4096.fvecs"
           --cluster-ids "$IVF_DATA/cluster_id_4096.ivecs" --queries-file "$IVF_DATA/sift_query.fbin"
           --gt "$IVF_DATA/gt.ibin")
