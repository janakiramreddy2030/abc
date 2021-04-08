#create region
provider "aws" {
    region = "ap-south-1"  
}
# create vpc 
resource "aws_vpc" "demo" {
    cidr_block = "10.0.0.0/16"
    tags = {
      "Name" = "Demo"
    }
}
resource "aws_subnet" "Mysubnet" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Mysubnet"
  }
}

