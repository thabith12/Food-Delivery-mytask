terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

data "aws_secretsmanager_secret" "rds_credentials" {
  name = "task21-rds-credentials"
}

data "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = data.aws_secretsmanager_secret.rds_credentials.id
}

locals {
  rds_credentials = jsondecode(
    data.aws_secretsmanager_secret_version.rds_credentials.secret_string
  )
}

resource "aws_db_instance" "task21_terraform_rds" {
  identifier = "task21-terraform-rds"

  engine         = "mysql"
  engine_version = "8.4.9"
  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = local.rds_credentials.dbname
  username = local.rds_credentials.username
  password = local.rds_credentials.password

  db_subnet_group_name = "task21-rds-subnet-group"

  vpc_security_group_ids = [
    "sg-0ab6fd0d8e3202ef9"
  ]

  publicly_accessible = false
  multi_az            = false

  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = {
    Name  = "task21-terraform-rds"
    Task  = "Task21"
    Owner = "Thabith"
  }
}
