# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#Creating module
module "ec2-instance" {
  source              = "./modules/ec2-instance"
  ami_value           = "ami-053a45fff0a704a47"
  instance_type_value = "t3.micro"
  subnet_id_value     = "subnet-0d6252821581a0f80"
}

#reading output from module output
output "module_ec2-instance" {
  value = module.ec2-instance.public-ip-addr
}