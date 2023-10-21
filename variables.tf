#VPC variables
variable "region" {
  default = "eu-west-1"
}

variable "vpc_name" {
  default = "my-vpc"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

#EKS Cluster variables
variable "cluster_name" {
  default = "my-eks-cluster"
}

variable "cluster_version" {
  default = "1.28"
}

variable "node_gr_name" {
  default = "my-node-group"
}

variable "instance_type" {
  default = "t3.small"
}

variable "node_max_size" {
  default = 2
}

variable "node_min_size" {
  default = 1
}

variable "node_des_size" {
  default = 2
}

#RDS variables
variable "rds_name" {
  default = "my-db"
}

variable "rds_storage_type" {
  default = "gp2"
}

variable "rds_engine" {
  default = "mysql"
}

variable "rds_version" {
  default = "5.7"
}

variable "rds_instance" {
  default = "db.t2.micro"
}

variable "rds_db_name" {
  default = "wordpress"
}

variable "rds_username" {
  default = "admin"
}

variable "rds_password" {
  default = "rootpass"
}

variable "rds_param_group" {
  default = "default.mysql5.7"
}

#Key variables
variable "key_name" {
  default = "eks-cluster"
}

variable "key_algorithm" {
  default = "RSA"
}

variable "key_rsa_bits" {
  default = 4096
}
  