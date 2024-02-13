resource "aws_subnet" "public-subnet" {
  # count             = 3
  count             = length(local.new_public_subnet_cidrs)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(local.new_public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name              = "${var.vpc_name}-PublicSubnet-${count.index + 1}"
    Terraform-Managed = "Yes"
    Env               = local.new_environment
    ProjectID         = local.projid
  }
}
