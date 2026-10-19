
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "web_sg" {
  name        = "skillpilot-task3-web-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    description = "SSH from authorized IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
   cidr_blocks = ["47.11.6.171/32"]
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "skillpilot-task3-web-sg"
    Project = "SkillPilot-Task3"
  }
}

resource "aws_instance" "web" {
  ami = "ami-094adff9b24048c5c"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name    = "skillpilot-task3-terraform-ec2"
    Project = "SkillPilot-Task3"
  }
}
