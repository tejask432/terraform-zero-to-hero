#Create a Instance
resource "aws_instance" "example" {
  ami           = var.ami_value
  instance_type = var.instance_type_value
  subnet_id     = var.subnet_id_value
  tags = {
    Name = "example-instance"
  }
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}