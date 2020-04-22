#! /bin/sh
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin $AWS_ID.dkr.ecr.ap-northeast-1.amazonaws.com/puma-with-nginx
docker build -t puma-with-nginx .
docker tag puma-with-nginx:latest $AWS_ID.dkr.ecr.ap-northeast-1.amazonaws.com/puma-with-nginx:latest
docker push $AWS_ID.dkr.ecr.ap-northeast-1.amazonaws.com/puma-with-nginx:latest
docker build -t puma-with-nginx-nginx ./nginx/
docker tag puma-with-nginx-nginx:latest $AWS_ID.dkr.ecr.ap-northeast-1.amazonaws.com/puma-with-nginx:nginx_latest
docker push $AWS_ID.dkr.ecr.ap-northeast-1.amazonaws.com/puma-with-nginx:nginx_latest