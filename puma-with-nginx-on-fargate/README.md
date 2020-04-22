# ecs-service-discovery

sample architecture for puma with Nginx on Fargate.
this directory includes sample sinatra application and CloufFormation templates.

Templates create following resources:

- VPC
- Public Subnet
- RouteTable
- InternetGateway
- ECR
- ECS Cluster
- IAM Role (for ECS Task)
- CloudWatch Logs Group (for ECS Task)
- Security Group (for ECS Task)
- ECS Task Definition
- ECS Service