## ECR Repo & Lifecycle policy creation

- Change directory to ECR `cd ECR`
- Create resources using terraform
    - Check terraform resource definitions in [main.tf](main.tf "Resource Definition")
    - `terraform init`
    - `terraform plan`
    - `terraform apply -auto-approve`
- Build and push images to repo
    - Change directory to pushImage `cd pushImage`
    - In `buildAndPushImage.sh`
        - Give your respective AWS `accountID`, ECR `repoUri`, `region` & `imageTag`
    - Run the Script `sh buildAndPushImage.sh`
    - The script will push the image and logs its vulnerability scan results
