variable "aws_region" { type = string }
variable "public_subnet_cidrs" { type = list(any) }
variable "private_subnet_cidrs" { type = list(any) }
variable "azs" { type = list(any) }
variable "vpc_cidr" { type = string }
variable "vpc_name" { type = string }
variable "environment" { type = string }
variable "projid" { type = string }
variable "key_name" { type = string }
variable "amis" { type = map(any) }
variable "instance_type" { type = map(any) }

