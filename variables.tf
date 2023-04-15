variable "instance_type" {
  type        = string
  default     = "t2.micro"
}
variable "ami" {
  type        = string
  default     = "ami-04581fbf744a7d11f"
}
variable "key_pair" {
  type        = string
  default     = "aswsdemo"
}
variable "security_group_id" {
  type        = set(string)
  default     = []
}

variable "subnet_id" {
  type        = string
  default     = ""
}

variable "vpc_id" {
  type        = string
  default     = "vpc-02d12d50a8c4ea141"
}
variable "internet_gateway_id" {
  type        = string
  default     = ""
}

variable "route_table_id" {
  type        = string
  default     = "rtb-0e1a54e7d55e55daa"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
}
