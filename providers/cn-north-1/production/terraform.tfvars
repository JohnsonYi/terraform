#--------------------------------------------------------------
# General
#--------------------------------------------------------------

name              = "scf-demo"
region            = "cn-north-1"
atlas_environment = "cq-demo"
atlas_username    = "REPLACE_IN_ATLAS"
site_public_key   = "REPLACE_IN_ATLAS"
site_private_key  = "REPLACE_IN_ATLAS" 
public_key_path   = "~/.ssh/cq-demo.pub" # No need to update until Vault is configured

#--------------------------------------------------------------
# Network
#--------------------------------------------------------------

vpc_cidr        = "130.95.0.0/16"
azs             = "cn-north-1" # AZs are region specific
private_subnets = "130.95.1.0/24" # Creating one private subnet per AZ
public_subnets  = "130.95.11.0/24" # Creating one public subnet per AZ

#--------------------------------------------------------------
# Compute
#--------------------------------------------------------------
# Jenkins
jenkins_ubuntu_user = "ubuntu"
jenkins_instance_type = "t2.small"
jenkins_ami = "ami-00xxxx9d"
jenkins_key_name = "cq-demo"
jenkins_in_sec_group = "cq-demo"
jenkins_in_subnet = "${var.name}-private-subnet.${var.region}"
jenkins_with_public_ip = true
jenkins_volume_type = "standard" 
jenkins_volume_size = 40
