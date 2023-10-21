#EKS Cluster creation using module
module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  version                        = "~> 19.0"
  cluster_name                   = var.cluster_name
  cluster_version                = var.cluster_version
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.public_subnets
  cluster_endpoint_public_access = true
  eks_managed_node_groups = {
    node_group = {
      name           = "${var.node_gr_name}"
      instance_types = ["${var.instance_type}"]
      min_size       = var.node_min_size
      max_size       = var.node_max_size
      desired_size   = var.node_des_size
      key_name       = var.key_name
    }
  }
}