#Generating key pair which should be saved locally once we run terraform apply
resource "tls_private_key" "ssh_key" {
  algorithm = var.key_algorithm
  rsa_bits  = var.key_rsa_bits
}

output "private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

output "public_key" {
  value     = tls_private_key.ssh_key.public_key_openssh
  sensitive = true
}

resource "aws_key_pair" "my-key-pair" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
  depends_on = [module.vpc]
}

resource "local_file" "key" {
  filename = "./eks-cluster.pem"
  content  = tls_private_key.ssh_key.private_key_pem
}