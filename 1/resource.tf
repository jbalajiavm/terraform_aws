provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "demovpc1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "demovpc1"
  }
}


############### outputs ###############
#terraform output before this
output "demovpc1_arn" {
  value = aws_vpc.demovpc1.arn
}
#terraform apply then output before this
output "demovpc1_id" {
  value = aws_vpc.demovpc1.id
}
output "demovpc1_cidr_block" {
  value = aws_vpc.demovpc1.cidr_block
}
output "demovpc1_instance_tenancy" {
  value = aws_vpc.demovpc1.instance_tenancy
}

############### subnets and data block ###############
resource "aws_subnet" "demosubnet1" {
  vpc_id     = aws_vpc.demovpc1.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "demosubnet1"
  }
}
############### subnets and data block ###############
data "aws_vpc" "selected" {
  id = aws_vpc.demovpc1.id
}

resource "aws_subnet" "demosubnet2" {
  vpc_id     = data.aws_vpc.selected.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "demosubnet2"
  }
}
/*
############### subnets and variables block with prompt ###############
variable "sub3_cidr" {
  description = "subnet3 cidr"
  type        = string
}

resource "aws_subnet" "demosubnet3" {
  vpc_id     = data.aws_vpc.selected.id
  cidr_block = var.sub3_cidr

  tags = {
    Name = "demosubnet3"
  }
}

############### subnets and variables block with prompt ###############
variable "sub4_cidr" {
  description = "subnet4 cidr"
  type        = string
  default = "10.0.4.0/24"
}

resource "aws_subnet" "demosubnet4" {
  vpc_id     = data.aws_vpc.selected.id
  cidr_block = var.sub4_cidr

  tags = {
    Name = "demosubnet4"
  }
}
#terraform show
#terraform destroy -auto-approve

terraform {
  backend "s3" {
    bucket = "terrademo-01122021"
    key    = "2_tfstate/terraform.tfstate"
    region = "ap-south-1"
  }
}
*/