#!/bin/bash

# Ref - https://www.jenkins.io/doc/book/installing/linux/
# Installing Jenkins
sudo apt update -y
sudo apt install wget -y
wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update -y
sudo apt install openjdk-17-jdk -y
sudo apt install jenkins -y
sudo systemctl daemon-reload

# Starting Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

# Ref - https://www.atlassian.com/git/tutorials/install-git
# Installing Git
sudo apt install -y git
git --version

# Installing Docker 
# Ref - https://www.cyberciti.biz/faq/how-to-install-docker-on-ubuntu/
sudo apt update
sudo apt install -y docker.io

# Add user to Docker group
sudo usermod -aG docker $USER
sudo usermod -aG docker jenkins
newgrp docker

sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo systemctl status docker.service

sudo chmod 777 /var/run/docker.sock

# Run Docker Container of Sonarqube
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

# Installing AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install

# Ref - https://developer.hashicorp.com/terraform/cli/install/apt
# Installing Terraform
# 1. Update and install dependencies
sudo apt update -y
sudo apt install -y gnupg software-properties-common curl

# 2. Add the HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# 3. Add the official HashiCorp Linux repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# 4. Update and install Terraform
sudo apt update -y
sudo apt install -y terraform

# 5. Verify installation
terraform -version

# Ref - https://kubernetes.io/docs/tasks/tools/install-kubectl/
# Installing kubectl
sudo curl -LO "https://dl.k8s.io/release/v1.23.6/bin/linux/amd64/kubectl"
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Installing Trivy
# Ref - https://aquasecurity.github.io/trivy-repo/
sudo apt install -y apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt update -y
sudo apt install -y trivy

# Installing Helm
# Ref - https://helm.sh/docs/intro/install/
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
