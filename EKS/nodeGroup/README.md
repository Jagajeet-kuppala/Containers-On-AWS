# Deploying Pods to EC2 worker nodes (Managed Node Groups)

## What are Node Groups ?
- Node Groups consist of one or more EC2 instances running the latest EKS-optimized AMIs.
- AMIs are configured to work with Amazon EKS out of the box, and include Docker, kubelet, and the AWS IAM Authenticator. 
- All managed nodes are provisioned as part of an Amazon EC2 Auto Scaling group that's managed by Amazon EKS.
- Select multiple subnets for a Node Group to provision nodes across multiple AWS availability zones.
- Nodes are automatically tagged for auto-discovery by the Kubernetes cluster autoscaler.

> In simple terms, <br>
> Node - A single EC2, where you define AMI, Instance type, Disk size, etc. <br>
> Node Group - Group of nodes managed by EKS using AutoScaler<br>
> Configure Min & Max no. of nodes to spin up, used by AutoScaler groups when workloads increase.
  
## Create a Managed Node Group using TF

> **IMPORTANT:** Node groups needs our networking resources (VPC, subnets, route tables, etc) to follow certain configurations. <br>
> To know more about EKS networking and corresponding TF scripts to create base Network setup look [here](../networking). <br>
1. Make sure your networking [setup](../networking) is as expected by EKS.
2. Change directory to EKS/nodeGroup `cd nodeGroup`
3. In `vars.tf`
    1. `cluster_name` should be same as the cluster you created. (To create a EKS cluster look into [setup](../cluster))
    2. Provide values for `node_group_name`, `subnet_ids` & `node_instance_types`
4. Apply Terraform
    1. `terraform init`
    2. `teraform plan`
    3. `terraform apply -auto-approve`

### Deploy Kubernetes official dashboard to your cluster
1. Deploy necessary resources  
    ```shell script
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
    ```
2. Port forward to localhost
    ```shell script
    kubectl proxy --port=8080 --address=0.0.0.0 --disable-filter=true &
    ```   
3. Access dashboard with URL
    ```
    http://localhost:8080/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy
    ``` 
4. Select auth type as `Token`
    ![Kubernetes Dashboard signin](../assets/Kubernetes%20Dashboard.png)
5. Generate bearer token and signin
    ```shell script
    aws eks get-token --cluster-name cluster | jq -r '.status.token'
    ```
6. Clean-up the dashboard when needed
    ```shell script
    # kill proxy
    pkill -f 'kubectl proxy --port=8080'
    
    # delete dashboard
    kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
    ```
### Deploy sample Pods using Kubectl
In this example we will try to deploy, <br>
- A sample microservice in the node (in private subnet)
- An ELB (in public subnet) & attach it to the microservice
> Note: Here, both the public & private subnet should be from same AZ. 
