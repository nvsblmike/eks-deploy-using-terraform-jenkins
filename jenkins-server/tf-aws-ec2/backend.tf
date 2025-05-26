terraform {
  backend "s3" {
    bucket = "terraform-eks-1925"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}