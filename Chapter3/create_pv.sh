#!/bin/bash
# -------参数说明
# SERVER：设置NFS Server的主机名或IP地址
# COUNT：创建PV的数量
# PV_CAPACITY：PV的容量大小
# PV_ACCESS_MODE: PV访问模式,支持ReadWriteOnce、ReadWriteMany、ReadOnlyMany
# STORAGE_CLASS_NAME: StorageClass名称

SERVER=xxx.xxx.xxx.xxx
COUNT=100
PV_CAPACITY=5Gi
PV_ACCESS_MODE=ReadWriteOnce
STORAGE_CLASS_NAME=standard


for i in $(seq 1 $COUNT); do
  PV=$(cat <<EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv$(printf %04d $i)
spec:
  storageClassName: $STORAGE_CLASS_NAME
  capacity:
    storage: $PV_CAPACITY
  accessModes:
    - $PV_ACCESS_MODE
  persistentVolumeReclaimPolicy: Recycle
  nfs:
    server: $SERVER
    path: /exports/pv$(printf %04d $i)  #后端NFS Server创建相应的目录和配置权限
  EOF
)

  echo "$PV" | oc create -f -
done
