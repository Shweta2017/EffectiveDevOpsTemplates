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
    inline = [
	"#!/bin/bash", 
	"export HOME=/home/ec2-user", 
	"sudo yum install -y git", 
	"sudo yum install -y pip",
	"sudo pip install ansible==2.9.26", 
	"/usr/bin/ansible-pull -U https://github.com/Shweta2017/EffectiveDevOpsTemplates helloworld.yml -i localhost"]
  }
}

# IP address of newly created EC2 instance
output "myserver" {
  value = "${aws_instance.myserver.public_ip}"
}
