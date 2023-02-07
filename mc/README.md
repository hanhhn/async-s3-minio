===========
Input ENV:

- S3_REGION=
- S3_AWS_ACCESS_KEY_ID=
- S3_AWS_SECRET_ACCESS_KEY=

- MINIO_REGION=
- MINIO_AWS_ACCESS_KEY_ID=
- MINIO_AWS_SECRET_ACCESS_KEY=
- MINIO_ENDPOINT=

===========

docker build -t sync-s3-minio-mc .

docker run \
    --env S3_REGION="ap-southeast-1" \
    --env S3_AWS_ACCESS_KEY_ID="AKIAS4KLDDKHXFEXDOG7" \
    --env S3_AWS_SECRET_ACCESS_KEY="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" \
    --env MINIO_REGION="ap-southeast-1" \
    --env MINIO_AWS_ACCESS_KEY_ID="mW2yJ3RHhpvE8ytJ" \
    --env MINIO_AWS_SECRET_ACCESS_KEY="EPW2twHVeIbrfLBwQSJpUdlOl81HdHgM" \
    --env MINIO_ENDPOINT="http://192.168.130.8:9000" \
    sync-s3-minio-mc
    /
