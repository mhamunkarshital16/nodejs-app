provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "node_app" {
  ami           = "ami-0f5ee92e2d63afc18" # Example Amazon Linux
  instance_type = "t3.micro"

  key_name = "my-key"

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install docker -y
              service docker start
              docker run -d -p 3000:3000 node-js:v1
              EOF

  tags = {
    Name = "NodeAppServer"
  }
}
