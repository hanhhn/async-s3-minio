#!/bin/bash
aws --version

aws configure set aws_access_key_id $S3_AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $S3_AWS_SECRET_ACCESS_KEY
aws configure set default.region $S3_REGION
#aws configure set default.output <your_default_output_format>

aws configure set profile.minio.aws_access_key_id $MINIO_AWS_ACCESS_KEY_ID
aws configure set profile.minio.aws_secret_access_key $MINIO_AWS_SECRET_ACCESS_KEY
aws configure set profile.minio.region $MINIO_REGION
#aws configure set profile.minio.output <your_default_output_format>

ENDPOINT=$MINIO_ENDPOINT

for bucket in `aws s3api list-buckets --query "Buckets[].Name" --output text`; do
    echo 'sync '$bucket
    aws s3 sync "s3://$bucket" ./$bucket

    HEAD_BUCKET=$(aws --endpoint-url $ENDPOINT s3api head-bucket --bucket $bucket --profile minio 2>&1)
    if [[ $HEAD_BUCKET =~ "Not Found" ]]; then
        echo "Bucket $bucket does not exist"
        echo "$bucket creating..."
        aws --endpoint-url $ENDPOINT s3api create-bucket --bucket $bucket --region $REGION --profile minio
    elif [[ $HEAD_BUCKET =~ "Forbidden" ]]; then
        echo "You do not have access to the bucket $bucket."
    else
        echo "Bucket $bucket really exists."
    fi
    echo "$bucket processing...."
    aws --endpoint-url $ENDPOINT s3 sync ./$bucket "s3://$bucket" --profile minio
    echo "$bucket done"
done

echo 'successful';