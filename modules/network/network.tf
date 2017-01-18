variable "name" { }
variable "vpc_cidr" { }
variable "public_subnets" { }
variable "private_subnets" { }
variable "azs" { }

module "vpc" {
    source = "./vpc"

    name = "${var.name}-vpc"
    cidr = "${var.vpc_cidr}"
}

module "public_subnet" {
    source = "./public_subnet"

    name = "${var.name}-public-subnet"
    vpc_id = "${module.vpc.vpc_id}"
    cidrs = "${var.public_subnets}"
    azs = "${var.azs}"
}

module "private_subnet" {
  source = "./private_subnet"

  name   = "${var.name}-private-subnet"
  vpc_id = "${module.vpc.vpc_id}"
  cidrs  = "${var.private_subnets}"
  azs    = "${var.azs}"
  # nat_gateway_ids = "${module.nat.nat_gateway_ids}"
}

resource "aws_security_group" "scf_sec_group" {
  name        = "${var.name}_sec_group"
  description = "Defualt sec group for scf"
  vpc_id      = "${module.vpc.vpc_id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# VPC
output "vpc_id"   { value = "${module.vpc.vpc_id}" }
output "vpc_cidr" { value = "${module.vpc.vpc_cidr}" }

# Subnets
output "public_subnet_ids"  { value = "${module.public_subnet.subnet_ids}" }
output "private_subnet_ids" { value = "${module.private_subnet.subnet_ids}" }