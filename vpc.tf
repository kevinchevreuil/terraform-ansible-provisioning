#Create a VPC ressource#
resource "aws_vpc" "kaisen" {
  cidr_block       = "10.2.0.0/16"
  instance_tenancy = "default"
  #  tags             = merge(local.aws_tags, { Name = "vpc-kaisen" }) 
}

#Create an internet gateway ressource#
resource "aws_internet_gateway" "kaisen" {
  vpc_id = aws_vpc.kaisen.id
  #  tags   = merge(local.aws_tags, { Name = "gateway-kaisen" })
}

#Create a route table ressource#
resource "aws_route_table" "kaisen" {
  vpc_id = aws_vpc.kaisen.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kaisen.id
  }
  #      tags       = merge(local.aws_tags, { Name = "route-table-kaisen" })
}

#Create a route table association ressource#
resource "aws_route_table_association" "kaisen" {
  subnet_id      = aws_subnet.kaisen.id
  route_table_id = aws_route_table.kaisen.id
}

#Create a VPC subnet ressource#
resource "aws_subnet" "kaisen" {
  vpc_id            = aws_vpc.kaisen.id
  cidr_block        = "10.2.1.0/24"
  availability_zone = "eu-west-2a"
  #  tags              = merge(local.aws_tags, { Name = "subnet-kaisen" })
}
