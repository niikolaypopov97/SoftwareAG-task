output "rds_endpoint" {
  value = aws_db_instance.my-db.endpoint
}

output "eks_lb" {
  value = kubernetes_service.wordpress_serv.status
}