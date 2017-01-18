variable "jenkins_ubuntu_user" { }
variable "jenkins_instance_type"  { }
variable "jenkins_ami" { }
variable "jenkins_key_name" { }
variable "jenkins_in_sec_group" { }
variable "jenkins_in_subnet" { }
variable "jenkins_with_public_ip" { }
variable "jenkins_volume_type" { }
variable "jenkins_volume_size" { }

# Create instance Jenkins
resource "aws_instance" "jenkins" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "${var.jenkins_ubuntu_user}" 

    # The connection will use the local SSH agent for authentication.
  }

  instance_type = "${var.jenkins_instance_type}" 

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${var.jenkins_ami}"

  # The name of our SSH keypair we created above.
  key_name = "${var.jenkins_key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${var.jenkins_in_sec_group}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${var.jenkins_in_subnet}"

  # Associate with public ip
  associate_public_ip_address = "${var.jenkins_with_public_ip}"

  # root block device which need 40G.
  root_block_device {
    volume_type = "${var.jenkins_volume_type}"
    volume_size = "${var.jenkins_volume_size}"
    delete_on_termination = true
  }

  # We run a remote provisioner on the instance after creating it.
  provisioner "remote-exec" {
    inline = [
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt-get -y update",
      "wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -"
      "sudo apt-get install jenkins",
    ]
  }
}