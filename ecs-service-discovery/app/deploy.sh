#! /bin/sh
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin $AWS_ID.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-service-discovery
docker build -t ecs-service-discovery .
docker tag ecs-service-discovery:latest $AWS_ID.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-service-discovery:latest
docker push $AWS_ID.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-service-discovery:latest
docker build -t ecs-service-discovery-nginx ./docker/nginx/
docker tag ecs-service-discovery-nginx:latest $AWS_ID.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-service-discovery:nginx_latest
docker push $AWS_ID.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-service-discovery:nginx_latest