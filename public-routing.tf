resource "aws_route_table" "terraform-public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name              = "${var.vpc_name}-MAIN_RT"
    Terraform-Managed = "Yes"
    Env               = local.new_environment
    ProjectID         = local.projid
  }
}



resource "aws_route_table_association" "terraform-public" {
  # count = 3
  count = length(local.new_public_subnet_cidrs)
  #Using * is called Splat Syntax
  subnet_id      = element(aws_subnet.public-subnet.*.id, count.index)
  route_table_id = aws_route_table.terraform-public.id
} 