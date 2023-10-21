#VPC Creation using vpc module
module "vpc" {
  source                       = "terraform-aws-modules/vpc/aws"
  name                         = var.vpc_name
  cidr                         = var.vpc_cidr
  azs                          = ["eu-west-1a", "eu-west-1b"]
  private_subnets              = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets               = ["10.0.101.0/24", "10.0.102.0/24"]
  map_public_ip_on_launch      = true
  create_database_subnet_group = true

  enable_nat_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_vpn_gateway   = true
}