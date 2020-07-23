# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "eu-central-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
module "ec2_t2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "Udacity T2"
  instance_count         = 4

  ami                    = "ami-00edb93a4d68784e3"
  instance_type          = "t2.micro"
  monitoring             = true
  subnet_id              = "subnet-097509dcbcf532172"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

/*
# TODO: provision 2 m4.large EC2 instances named Udacity M4
module "ec2_m4_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "Udacity M4"
  instance_count         = 2

  ami                    = "ami-00edb93a4d68784e3"
  instance_type          = "m4.large"
  monitoring             = true
  subnet_id              = "subnet-097509dcbcf532172"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
*/