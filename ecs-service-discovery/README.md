# ecs-service-discovery

cf. [ECSのサービスディスカバリーを試す](https://bluepixel.hatenablog.com/entry/2020/04/05/233445)

sample architecture using ecs service discovery.
this directory includes sample sinatra application and CloufFormation templates.

Templates create following resources:

- VPC
- Public Subnet
- Private Subnet
- RouteTable
- InternetGateway
- EIP
- NATGateway
- Cloud Map Namespacce
- Cloud Map Service
- Route53 Private Hosted Zone
- ECR
- ECS Cluster
- IAM Role (for ECS Task)
- CloudWatch Logs Group (for ECS Task)
- Security Group (for ECS Task)
- ECS Task Definition
- ECS Service
- Security Group (for EC2 Instance)
- EC2 Instance (test service discovery)
