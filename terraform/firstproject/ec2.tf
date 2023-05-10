terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  access_key = "AKIA4MCWO5QBG2WZIL3C"
  secret_key = "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"
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
}
