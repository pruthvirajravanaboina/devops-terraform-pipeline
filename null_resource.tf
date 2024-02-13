resource "null_resource" "cluster" {
  count = local.new_environment == "production" ? 3 : 1
  provisioner "file" {
    source      = "script.sh"      # terraform machine
    destination = "/tmp/script.sh" # remote machine
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("terraform_new.pem")
      host        = element(aws_instance.webservers.*.public_ip, count.index)
    }
  }
  provisioner "file" {
    source      = "node_exporter.service"      # terraform machine
    destination = "/tmp/node_exporter.service" # remote machine
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("terraform_new.pem")
      host        = element(aws_instance.webservers.*.public_ip, count.index)
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/script.sh",
      "sudo /tmp/script.sh",
      # "sudo sed -i '/<h1>Testing Phase.*/a <h1>${var.vpc_name}-PublicServer-${count.index +1}</h1>' /var/www/html/index.nginx-debian.html"
      "sudo useradd --no-create-home --shell /bin/false node_exporter",
      "wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz",
      "tar xvf node_exporter-1.3.1.linux-amd64.tar.gz",
      "sudo cp node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin/",
      "sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter",
      "sudo cp /tmp/node_exporter.service /lib/systemd/system/node_exporter.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl start node_exporter",
      "sudo systemctl restart node_exporter",
      "sudo systemctl enable node_exporter",
      "sudo systemctl status node_exporter --no-pager",
      "rm -rf node_exporter*"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("terraform_new.pem")
      host        = element(aws_instance.webservers.*.public_ip, count.index)
    }
  }
  provisioner "local-exec" {
    command = <<EOH
      echo "${element(aws_instance.webservers.*.public_ip, count.index)}" >> public_server_details_1 && echo "${element(aws_instance.webservers.*.private_ip, count.index)}" >> public_server_details_2,
    EOH
  }
}