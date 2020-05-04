#!/bin/sh
echo "hello from lambda" >> sample.lambda
echo "hello from sns" >> sample.sns
echo "hello from sqs" >> sample.sqs
aws s3 cp ./sample.lambda s3://$BUCKET/
aws s3 cp ./sample.sns s3://$BUCKET/
aws s3 cp ./sample.sqs s3://$BUCKET/