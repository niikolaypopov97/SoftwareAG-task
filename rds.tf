#Creating security group for RDS allowing access on port 3306
resource "aws_security_group" "rds-sg" {
  name   = "rds-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "db_sub_rds" {
  name       = "my-rds-subnet-gr"
  subnet_ids = module.vpc.private_subnets
}

#Creation of the RDS 
resource "aws_db_instance" "my-db" {
  allocated_storage      = 20
  identifier             = var.rds_name
  storage_type           = var.rds_storage_type
  engine                 = var.rds_engine
  engine_version         = var.rds_version
  instance_class         = var.rds_instance
  db_name                = var.rds_db_name
  username               = var.rds_username
  password               = var.rds_password
  parameter_group_name   = var.rds_param_group
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = ["${aws_security_group.rds-sg.id}"]
  db_subnet_group_name   = aws_db_subnet_group.db_sub_rds.name
  depends_on             = [module.vpc]
}