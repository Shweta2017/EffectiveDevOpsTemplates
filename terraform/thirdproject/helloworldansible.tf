terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
}

# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami = "ami-022d03f649d12a49d"
  instance_type = "t2.micro"
  key_name = "EffectiveDevOpsAWS"
  vpc_security_group_ids = ["sg-036b11ec376df1f8d"]
  tags = {
    Name = "helloworld"
  }

  provisioner "remote-exec" {
    connection {
      user = "ec2-user"
      host = self.public_ip
      private_key = "${file("/home/shweta/.ssh/EffectiveDevOpsAWS.pem")}"
    }
    inline = ["#!/bin/bash", "export HOME=/home/ec2-user", "export NVM_DIR=/home/ec2-user/.nvm"]
  }
  provisioner "local-exec" {
    command = "echo '${self.public_ip}' > ./myinventory"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i myinventory --private-key=/home/shweta/.ssh/EffectiveDevOpsAWS.pem helloworld.yml"
  }
}

# IP address of newly created EC2 instance
output "myserver" {
  value = "${aws_instance.myserver.public_ip}"
}
