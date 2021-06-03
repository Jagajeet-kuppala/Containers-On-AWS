# EKS Cluster Creation using Terraform

### About EKS control plane
- The Amazon EKS control plane consists of control plane nodes that run the Kubernetes software, such as etcd and the Kubernetes API server. 
- The control plane runs in an account managed by AWS, and the Kubernetes API is exposed via the Amazon EKS endpoint associated with your cluster. 
- Each Amazon EKS cluster control plane is single-tenant and unique, and runs on its own set of Amazon EC2 instances.

### Prerequisites
- Development environment [setup](../../README.md#DEV_SETUP) is done
- VPC, subnets & security groups already created according to the [requirements](../networking)  

### Create Cluster with Add-ons
- `cd EKS`
- In `vars.tf` add your cluster name and subnet-ids
- `terraform init`
- `terraform apply -auto-approve`
- This creates a managed Kubernetes Control Plane

#### Cluster Add-ons
Recommended add-ons for EKS cluster
- **VPC-CNI** 
    - Container Network Interface
    - This plugin allows Kubernetes pods to have the same IP address inside the pod as they do on the VPC network
- **CoreDNS** *(kind: Deployment)*
    - CoreDNS is a flexible, extensible DNS server that can serve as the Kubernetes cluster DNS.
    - CoreDNS Pods provide name resolution for all Pods in the cluster.
    - The CoreDNS Pods can be deployed to Fargate nodes if your cluster includes an AWS Fargate profile.
- **Kube-proxy** *(kind: DaemonSet)*
    - Kube-proxy enables network communication to your pods.
    - Maintains network rules on each Amazon EC2 node
    - Kube-proxy is not deployed to Fargate nodes.

#### Connecting to EKS API server using kubectl
> **Note:** For any auth errors while using kubectl to connect refer [here](https://aws.amazon.com/premiumsupport/knowledge-center/eks-api-server-unauthorized-error/)

![Connecting with EKS using Kubectl](../assets/Connecting%20with%20EKS.png)
<div style="text-align: center; font-style: italic;">Fig: Connecting with EKS using Kubectl</div><br>

- The user configured in CLI should be cluster creator or should have been assigned access to it
- Connect kubectl to your AWS cluster using,
  ```shell script
  aws eks update-kubeconfig --name cluster --region ap-south-1
  ```
- View your cluster config 
  ```shell script
  kubectl config view --minify
  ```
