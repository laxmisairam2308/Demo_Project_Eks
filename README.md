#!/bin/bash
yum update -y
yum install -y docker git
amazon-linux-extras enable docker
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Terraform
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum -y install terraform


====
Change your vpc id & subnet id's in main.tf file, we need 2 subnets
vpc_id     = "vpc-06d0215b517ff6dca"
subnet_ids = ["subnet-017effb392c93f8c4","subnet-0891da2248f9e8252"]

====
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].[InstanceId,VpcId,SubnetId,Placement.AvailabilityZone]" \
  --output table

====
Need to create setup.sh file and run it

====
docker build -t sample-app .


====
aws ecr create-repository --repository-name sample-app

====

{
    "repository": {
        "repositoryArn": "arn:aws:ecr:us-east-1:818471591518:repository/sample-app",
        "registryId": "818471591518",
        "repositoryName": "sample-app",
        "repositoryUri": "818471591518.dkr.ecr.us-east-1.amazonaws.com/sample-app",
        "createdAt": "2025-05-16T19:57:38.829000+00:00",
        "imageTagMutability": "MUTABLE",
        "imageScanningConfiguration": {
            "scanOnPush": false
        },
        "encryptionConfiguration": {
            "encryptionType": "AES256"
        }
    }
}


====
aws ecr get-login-password | docker login --username AWS --password-stdin 818471591518.dkr.ecr.us-east-1.amazonaws.com

====
docker tag sample-app:latest 818471591518.dkr.ecr.us-east-1.amazonaws.com/sample-app:latest

====
docker push 818471591518.dkr.ecr.us-east-1.amazonaws.com/sample-app:latest

====
aws eks update-kubeconfig --name demo-cluster --region us-east-1

====
helm install myapp .

====
Change the eks API server endpoint access from Private to Public

====
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 818471591518.dkr.ecr.us-east-1.amazonaws.com

====
