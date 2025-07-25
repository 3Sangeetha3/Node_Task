provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "node_app" {
  ami           = "ami-0d03cb826412c6b0f" 
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install docker -y
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              docker run -d -p 4000:4000 3sangeetha3/node-task
            EOF

  tags = {
    Name = "NodeAppEC2"
  }

  vpc_security_group_ids = [aws_security_group.allow_traffic.id]
}

resource "aws_security_group" "allow_traffic" {
  name_prefix = "allow-traffic"

  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
