terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.5"

    }
  }
  required_version = "~>1.2"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "test-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-vpc"
  }
}

resource "aws_internet_gateway" "test-igw" {
  vpc_id = aws_vpc.test-vpc.id

  tags = {
    Name = "test-igw"
  }
}
resource "aws_subnet" "pub-sub" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "test-subnet"
  }
}

resource "aws_route_table" "test-routetab" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    Name = "routetab"
  }

}

resource "aws_route" "test_rt" {
  route_table_id         = aws_route_table.test-routetab.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test-igw.id
}

resource "aws_route_table_association" "rt-pub" {
  subnet_id      = aws_subnet.pub-sub.id
  route_table_id = aws_route_table.test-routetab.id
}

resource "aws_security_group" "testsec" {
  vpc_id = aws_vpc.test-vpc.id

  ingress {
    from_port  = 80
    to_port    = 80
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webtest"
  }
}
resource "aws_instance" "example" {
  ami             = "ami-084568db4383264d4"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.testsec.id]
    subnet_id       = aws_subnet.pub-sub.id
  tags = {
    Name = "mywebserver"
  }

}