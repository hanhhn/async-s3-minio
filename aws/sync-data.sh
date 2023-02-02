#!/bin/bash
region=[Input]
endpoint=[Input] #http://192.168.1.8:9000
aws --version
for bucket in `aws s3api list-buckets --query "Buckets[].Name" --output text`; do
    echo 'sync '$bucket
    aws s3 sync "s3://$bucket" ./$bucket
    aws --endpoint-url $endpoint s3api create-bucket --bucket $bucket --region $region --profile minio
    aws --endpoint-url $endpoint s3 sync ./$bucket "s3://$bucket" --profile minio
done

echo 'successful';