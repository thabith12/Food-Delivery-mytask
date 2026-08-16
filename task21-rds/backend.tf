terraform {
  backend "s3" {
    bucket       = "task21-terraform-state-thabith12-643603452212"
    key          = "task21/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
    encrypt      = true
  }
}
