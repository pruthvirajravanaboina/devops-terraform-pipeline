resource "aws_instance" "webservers" {
  count                       = local.new_environment == "production" ? 3 : 1
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = lookup(var.instance_type, local.new_environment)
  key_name                    = var.key_name
  subnet_id                   = element(aws_subnet.public-subnet.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true

  tags = {
    Name              = "${var.vpc_name}-PublicServer-${count.index + 1}"
    Terraform-Managed = "Yes"
    Env               = local.new_environment
    ProjectID         = local.projid
  }
  user_data = <<-EOF
		#!/bin/bash
    sudo apt-get update
		sudo apt-get install -y nginx
		sudo systemctl start nginx
		sudo systemctl enable nginx
		echo "<center><h1>${var.vpc_name}-PublicServer-${local.new_environment}-${count.index + 1}</h1></center><" | sudo tee /var/www/html/index.html
	EOF
  lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
  }

}

