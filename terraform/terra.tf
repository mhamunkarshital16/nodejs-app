provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "node_sg" {
    name = "node-sg"
    description = "Allow Node.js app traffic"

    ingress {
      description = "Allow HTTP (app port)"
      from_port = 3000
      to_port = 3000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
       description = "Allow SSH"
       from_port = "22"
       to_port = "22"
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }

}


resource "aws_instance" "node_app" {
  ami           = "ami-0f5ee92e2d63afc18" # Example Amazon Linux
  instance_type = "t3.micro"

  key_name = "test-app_key"

  vpc_security_group_ids = [aws_security_group.node_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install docker.io -y
              sudo usermod -aG docker $USER && newgrp docker
              docker run -d -p 3000:3000 node-js:v1
              EOF

  tags = {
    Name = "NodeAppServer-1"
  }
}
