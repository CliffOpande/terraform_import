resource "aws_subnet" "pipeline_public_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = "172.31.0.0/24"

  tags = {
    Name = "pipeline_public_subnet"
    project   = "pipeline"
    environment = "dev"
    owner = "Cliff_Philip"
  }
}

resource "aws_instance"  "jenkins" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_pair
  monitoring             = true
  associate_public_ip_address = true
  vpc_security_group_ids = var.security_group_id 
  subnet_id              = var.subnet_id

  tags = {
    Name = "jenkins"
    project   = "pipeline"
    environment = "dev"
    owner = "Cliff_Philip"
  }
}
resource "aws_instance"  "nexus" {

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_pair
  monitoring             = true
  associate_public_ip_address = true
  vpc_security_group_ids = var.security_group_id 
  subnet_id              = var.subnet_id

  tags = {
    Name = "nexus"
    project   = "pipeline"
    environment = "dev"
    owner = "Cliff_Philip"
  }
}
resource "aws_security_group" "dev-sg" {
  name        = "dev-sg"
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
  }

  tags = {
    Name = "dev-sg"
    project   = "pipeline"
    environment = "dev"
    owner = "Cliff_Philip"
  }
}
resource "aws_route_table" "pipeline_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id     


  }
  
  tags = {
    Name = "pipeline-route-table"
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
