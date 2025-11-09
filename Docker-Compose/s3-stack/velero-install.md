Набор команд для установки Velero:

```bash
curl -sSL https://github.com/vmware-tanzu/velero/releases/download/v1.17.0/velero-v1.17.0-linux-amd64.tar.gz -o velero-linux-amd64.tar.gz
tar -xvf velero-linux-amd64.tar.gz
mv velero-*/velero ~/.local/bin/
rm -rf velero-*
velero version

velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.13.0 \
    --bucket velero \
    --secret-file ./velero-minio.env \
    --backup-location-config region=minio,s3ForcePathStyle=true,s3Url=http://192.168.3.101:9000 \
    --namespace velero

kubectl get pods -n velero
kubectl logs deploy/velero -n velero
velero backup-location get
```