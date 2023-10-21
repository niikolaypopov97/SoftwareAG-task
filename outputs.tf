# output "cluster_name" {
#   value = module.eks.cluster_name
# }

# output "cluster_endpoint" {
#   value = module.eks.cluster_endpoint
# }

output "rds_endpoint" {
  value = aws_db_instance.my-db.endpoint
}

# output "cluster_sec_group" {
#   value = module.eks.cluster_security_group_id
# }

output "eks_lb" {
  value = kubernetes_service.wordpress_serv.status
}