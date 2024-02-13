output "vpc_id" {
  value = aws_vpc.default.id
}

output "sg_id" {
  value = aws_security_group.allow_all.id
}