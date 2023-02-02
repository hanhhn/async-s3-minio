#!/bin/bash
export PATH=$PATH:$HOME/minio-binaries/
mc --version
for bucket in `aws s3api list-buckets --query "Buckets[].Name" --output text`; do
    echo 'sync '$bucket
    mc admin info minio
    mc mb minio/$bucket
    mc mirror --watch s3/$bucket minio/$bucket
done

echo 'successful';