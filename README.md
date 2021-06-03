# Containers on AWS

#### Container services offered by AWS
![AWS Container services](assets/AWS%20Container%20services.png)
<br>

Learn about the services and use them instantly using Terraform scripts with the following guides. Before that, please [setup](#DEV_SETUP) your local environment.
- [Elastic Container Registry (ECR)](ECR)
- AWS Fargate
- [Elastic Kubernetes Service (EKS)](EKS)
- Elastic Container Service (ECS)

> For complete K8s and EKS usages and demos look at [eksworkshop.com](https://www.eksworkshop.com/ "EKS Workshop")

#### Development Environment Setup<a name="DEV_SETUP"></a>

- Install [Docker](https://docs.docker.com/engine/install/ "Install Docker")
- Install [Kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl "Install Kubectl")
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
