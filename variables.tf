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
variable "security_group" {
  type        = set(string)
  default     = ["sg-0158ac2f66e458159"]
}
variable "subnet_id" {
  type        = string
  default     = "subnet-071b0ceeae26ca168"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-02d12d50a8c4ea141"
}
variable "internet_gateway_id" {
  type        = string
  default     = "pipeline-internet-gateway"
}
variable "route_table_id" {
  type        = string
  default     = "rtb-08171bddd887fd24b"
}
variable "aws_region" {
  type        = string
  default     = "us-east-1"
}