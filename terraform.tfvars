aws_region           = "us-east-1"
vpc_cidr             = "10.35.0.0/16"
environment          = "PRODUCTION"
vpc_name             = "DevOps-aws"
public_subnet_cidrs  = ["10.35.1.0/24", "10.35.2.0/24", "10.35.3.0/24", "10.35.1.0/24", "10.35.2.0/24", "10.35.3.0/24"]
private_subnet_cidrs = ["10.35.10.0/24", "10.35.20.0/24", "10.35.30.0/24"]
azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
projid               = "PHENIOX_123"
key_name             = "terraform_new"
instance_type = {
  development = "t2.micro"
  testing     = "t2.small"
  production  = "t2.micro"
}
amis = {
  us-east-1 = "ami-0fdf974becf56039f"
  us-east-2 = "ami-0430580de6244e02e"
}