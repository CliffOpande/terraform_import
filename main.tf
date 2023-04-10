resource "aws_instance"  "instance-Jenkins" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_pair
  monitoring             = true
  vpc_security_group_ids = var.security_group
  subnet_id              = var.subnet_id

  tags = {
    name = "instance-Jenkins"
    project   = "pipeline"
    environment = "dev"
    owner = "Cliff_Philip"
  }
}
resource "aws_instance"  "instance-Nexus" {

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_pair
  monitoring             = true
  vpc_security_group_ids = var.security_group
  subnet_id              = var.subnet_id

  tags = {
    name = "instance-Nexus"
    project   = "pipeline"
    environment = "dev"
    owner = "Cliff_Philip"
  }
}
resource "aws_security_group" "launch-wizard-1" {
  name        = "launch-wizard-1"
  description = "launch-wizard-1 created 2023-03-15T20:59:40.748Z"
  vpc_id      = var.vpc_id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "HTTPS"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    name = "dev-sg"
    project   = "pipeline"
    environment = "dev"
    owner = "Cliff_Philip"
  }
}
resource "aws_subnet" "pipeline_public_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.1.0/24"

  tags = {
    name = "dev-public-subnet"
    project   = "pipeline"
    environment = "dev"
    owner = "Cliff_Philip"
  }
}
resource "aws_route_table" "pipeline_route_table" {
  vpc_id = var.vpc_id


  tags = {
    name = "pipeline-route-table"
    project   = "pipeline"
    environment = "dev"
    owner = "Cliff_Philip"
  }
}

resource "aws_route_table_association" "pipeline_rt_subnet_association" {
  subnet_id      = var.subnet_id
  route_table_id = var.route_table_id
}

resource "aws_internet_gateway" "pipeline_internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    name = "pipeline-internet-gateway"
    project   = "pipeline"
    environment = "dev"
    owner = "Cliff_Philip"
  }
}
terraform {
  backend "s3" {
    bucket = "cliff-s3-bucket"
    key    = "./terraform.tfstate"
    region = "us-east-1"
  }
}