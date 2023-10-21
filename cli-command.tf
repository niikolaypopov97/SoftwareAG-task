#Configuring kubectl with eks locally using local-exec
resource "null_resource" "update_eks_conf" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${var.cluster_name}"
  }
  depends_on = [module.eks.eks_managed_node_groups]
}