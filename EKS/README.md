# Elastic Kubernetes Service (EKS)

1. Get your base networking (VPC, subnets, route table) as expected by EKS. Look into [EKS Networking](networking).
2. For creating EKS cluster look into [EKS Cluster creation](cluster).
3. For deploying pods into EC2 worker nodes look into [Node Groups](nodeGroup) .

EKS is an AWS service offering fully managed, highly available Kubernetes control plane & data plane. Which allows us to manage highly scalable workloads (pods) on Kubernetes worker nodes.
![Kubernetes Control Plane](assets/K8s%20architecture.png)
<div style="text-align: center; font-style: italic;">Fig: Kubernetes Architecture</div><br>

AWS creates a manged Control Plane and you can attach your managed Worker Nodes your cluster. The architecture is depicted in below picture.
![EKS Architecture](assets/EKS%20Control%20plane%20communication.png "EKS Control Plane communication")  
<div style="text-align: center; font-style: italic;">Fig: EKS Control Plane and Worker Node communication </div><br>

### Pricing 

| Resource type      | Cost (USD)                                                          |
| ------------------ | ------------------------------------------------------------------- |
| EKS Control Plane  | 0.10 / Hour / Cluster                                               |
| Node Groups (EC2)  | Pay only for resources used (EC2, EBS volumes). No additional costs |
