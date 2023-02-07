#!/bin/bash
export PATH=$PATH:$HOME/minio-binaries/
mc --version

aws configure set aws_access_key_id $S3_AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $S3_AWS_SECRET_ACCESS_KEY
aws configure set default.region $S3_REGION

S3_ENDPOINT=https://s3.amazonaws.com
mc alias set s3 $S3_ENDPOINT $S3_AWS_ACCESS_KEY_ID $S3_AWS_SECRET_ACCESS_KEY
mc alias set minio $MINIO_ENDPOINT $MINIO_AWS_ACCESS_KEY_ID $MINIO_AWS_SECRET_ACCESS_KEY

for bucket in `aws s3api list-buckets --query "Buckets[].Name" --output text`; do
    echo 'sync '$bucket
    mc admin info minio
    
    HEAD_BUCKET=$(mc ls minio/$bucket 2>&1)
    if [[ $HEAD_BUCKET =~ "ERROR" ]]; then
        echo "Bucket $bucket does not exist."
        echo "$bucket creating..."
        mc mb minio/$bucket
    else
        echo "Bucket $bucket really exists."
    fi
    
    echo "$bucket processing...."
    mc mirror --watch s3/$bucket minio/$bucket
    echo "$bucket done"
done

echo 'successful';