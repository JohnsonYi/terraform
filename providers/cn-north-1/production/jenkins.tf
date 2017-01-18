variable "ubuntu_user" { }
variable "jenkins_instance_type"  { }
variable "jenkins_ami" { }
variable "jenkins_key_name" { }
variable "jenkins_in_sec_group" { }
variable "jenkins_in_subnet" { }
variable "jenkins_with_public_ip" { }
variable "jenkins_volume_type" { }
variable "jenkins_volume_size" { }

module "jenkins" {
  source = "../../../modules/compute/jenkins"

  jenkins_ubuntu_user    =  "${var.jenkins_ubuntu_user}"
  jenkins_instance_type  =  "${var.jenkins_instance_type}"
  jenkins_ami            =  "${var.jenkins_ami}"
  jenkins_key_name       =  "${var.jenkins_key_name}"
  jenkins_in_sec_group   =  "${var.jenkins_in_sec_group}"
  jenkins_in_subnet      =  "${var.jenkins_in_subnet}"
  jenkins_with_public_ip =  "${var.jenkins_with_public_ip}"
  jenkins_volume_type    =  "${var.jenkins_volume_type}"
  jenkins_volume_size    =  "${var.jenkins_volume_size}"
}