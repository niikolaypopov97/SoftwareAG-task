provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_path            = "~/.kube/config"
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

#Saving remote states on software-ag-task bucket which I created manually
terraform {
  backend "s3" {
    bucket = "software-ag-task"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}