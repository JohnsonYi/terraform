variable "region" { }
variable "atlas_username"    { }
variable "atlas_environment" { }
variable "public_key_path"  { }

provider "aws" {
  region = "${var.region}"
}

atlas {
  name = "${var.atlas_username}/${var.atlas_environment}"
}

resource "aws_key_pair" "site_key" {
  key_name   = "${var.atlas_environment}"
  public_key = "${file(var.public_key_path)}"

  lifecycle { create_before_destroy = true }
}

module "network" {
  source = "../../../modules/network"

  name            = "${var.name}"
  vpc_cidr        = "${var.vpc_cidr}"
  azs             = "${var.azs}"
  region          = "${var.region}"
  private_subnets = "${var.private_subnets}"
  public_subnets  = "${var.public_subnets}"
}