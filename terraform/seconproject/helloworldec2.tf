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

  provisioner "remote-exec" {
    connection {
      user = "ec2-user"
      host = self.public_ip
      private_key = "${file("/home/shweta/.ssh/EffectiveDevOpsAWS.pem")}"
    }
    inline = [
	"export HOME=/home/ec2-user",
	"curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash",
    	". ~/.nvm/nvm.sh",
    	"nvm install --lts",
    	"nvm install 16",
    	"wget http://bit.ly/2vESNuc -O /home/ec2-user/helloworld.js",
    	"sudo wget https://raw.githubusercontent.com/Shweta2017/test_repo/main/helloworld.service -O /etc/systemd/system/helloworld.service",
    	"sudo systemctl daemon-reload",
    	"sudo systemctl start helloworld.service"
    ]
  }
}


