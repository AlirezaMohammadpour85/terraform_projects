# Steps to create ECR and ECS-Fargate using terraform
1- create ignore file
2- create provider.tf file 
    - create provider.tf file for AWS
    - create aws secret key and access key in AWS IAM - (https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html) 
      - aws configure --profile userprod
            AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
            AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
            Default region name [None]: us-west-2
            Default output format [None]: json

3- create main.tf file - in root folder
4- create variables.tf file in root folder
5- create output.tf file in each module
6- create ecr.tf file in ecr module
7- create ecs.tf file - in ecs module
8- create networking files in network module
    - create vpc.tf file
    - create subnets.tf file
    - create security_groups.tf file
    - create route_tables.tf file
    - create route_associate.tf file
    - create variable.tf
9- create data source files:
