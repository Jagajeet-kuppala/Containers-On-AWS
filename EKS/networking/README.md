# EKS Networking 

For EKS to use its worker nodes, the underlying networking configuration has to be compatible and discoverable by the control plane.
This includes networking components such as VPC, subnets, route tables, security groups, internet gateway(IG) & NAT gateway. 

> [Skip](#PROD_SETUP) to our example setup and prescribed production grade setup TF.

### VPC Considerations:
- Create VPC with CIDR block with enough IP addresses
- For EKS to discover your VPC, add the following tag to your VPC

| Key                                  | Value  |
| ------------------------------------ | ------ |
| kubernetes.io/cluster/<cluster-name> | shared |

### Subnet Considerations:
> **Note:** Your VPC must have atleast 2 subnets in different AZs in same region. 

You VPC can one of the following subnet configurations,
##### 1. Only public subnets
- Has atleast 2 subnets in different AZs in same region.
- All nodes are automatically assigned public IP addresses and can send and receive internet traffic through an internet gateway. 
- A security group is deployed that denies all inbound traffic and allows all outbound traffic.
- Tagging requirements for subnet    

| Key                                  | Value  |
| ------------------------------------ | ------ |
| kubernetes.io/cluster/<cluster-name> | shared |
| kubernetes.io/role/elb               | 1      |

##### 2. Only private subnets
- Has atleast 2 subnets in different AZs in same region.
- All nodes can optionally send and receive internet traffic through a NAT instance or NAT gateway. 
- A security group is deployed that denies all inbound traffic and allows all outbound traffic.
- Tagging requirements

| Key                                  | Value  |
| ------------------------------------ | ------ |
| kubernetes.io/cluster/<cluster-name> | shared |
| kubernetes.io/role/internal-elb      | 1      |

##### 3. Public and private subnets
- Recommended option for all production deployments.
- Deploys nodes to private subnets.
- Allows Kubernetes to deploy load balancers to the public subnets that can load balance traffic to pods running on nodes in the private subnets.
- Public IP addresses are automatically assigned to resources deployed to one of the public subnets.
- Resources in private subnet connect to internet / control plane using NAT gateway in public subnet of **corresponding AZ**.   
- AZ with private subnets should have atleast 1 public subnet.
- Subnets should be from atleast 2 different AZs.
- Tagging requirements,

| Key                                  | Value  | Subnet Type            |
| ------------------------------------ | ------ | ---------------------- |
| kubernetes.io/cluster/<cluster-name> | shared | Public & Private       |
| kubernetes.io/role/internal-elb      | 1      | Private                | 
| kubernetes.io/role/elb               | 1      | Public                 | 
