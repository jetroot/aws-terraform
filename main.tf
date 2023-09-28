terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.18.1"
    }
  }

  required_version = ">= 1.5.7"
}

provider "aws" {
  region = "ap-southeast-2"
}

# 1. Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

# 2. Create Subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_block

  tags = {
    Name = var.subnt_name
  }
}

# 3. Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# 4. Create Route Table
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example"
  }
}

# 5. Associate Route table with subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.example.id
}

# 6. Create Security Group to allow port 80, 443
resource "aws_security_group" "allow_traffic" {
  name        = "allow_web_traffic"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow http traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow https traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_traffic"
  }
}

# 7. Create EC2 & install Nginx
resource "aws_instance" "my_instance" {
  ami           = "ami-0310483fb2b488153"
  instance_type = "t2.micro"

  security_groups             = [aws_security_group.allow_traffic.id]
  subnet_id                   = aws_subnet.main.id
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    echo '<h1>it worked</h1>' > /var/www/html/index.html
    systemctl enable nginx
    systemctl start nginx
  EOF

  tags = {
    Name = var.instance_name
  }
}

