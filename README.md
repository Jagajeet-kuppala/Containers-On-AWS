# Containers on AWS

#### Container services offered by AWS
- [Elastic Container Registry (ECR)](ECR/README.md)
- AWS Fargate
- Elastic Kubernetes Service (EKS)
- Elastic Container Service (ECS)

#### Development Environment Setup

- Install [Docker](https://docs.docker.com/engine/install/ "Install Docker")
- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform "Install Terraform")
- Install [jq](https://stedolan.github.io/jq/download/ "Install jq")
- Configure AWS CLI 
    - Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html "Install AWS CLI")
    - Download Access & Secret Keys for your IAM user
    - Create named profile
      ```shell
      $ aws configure --profile produser
      AWS Access Key ID [None]: AKIAI44QH8DHBEXAMPLE
      AWS Secret Access Key [None]: je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
      Default region name [None]: us-east-1
      Default output format [None]: text
      ```
    - Export profile on every new terminal session
      ```shell
      $ export AWS_PROFILE=produser
      ```
