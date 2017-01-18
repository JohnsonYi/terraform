# Specify the provider and access credentials
provider "aws" {
  region = "${var.aws_region}"
}

# Create a SCF VPC to launch our instances into
resource "aws_vpc" "demo-vpc" {
    cidr_block = "130.95.0.0/16"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "demo-gw" {
    vpc_id = "${aws_vpc.demo-vpc.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "demo_internet_route" {
  route_table_id         = "${aws_vpc.demo-vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.demo-gw.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "demo-private-subnet" {
  vpc_id                  = "${aws_vpc.demo-vpc.id}"
  cidr_block              = "130.95.1.0/24"
  map_public_ip_on_launch = true
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "demo_sec_group" {
  name        = "demo_sec_group"
  description = "Defualt sec group for scf"
  vpc_id      = "${aws_vpc.demo-vpc.id}"

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

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

# Create instance Jenkins
resource "aws_instance" "jenkins" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "ubuntu"

    # The connection will use the local SSH agent for authentication.
  }

  instance_type = "t2.small"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair we created above.
  key_name = "${aws_key_pair.auth.id}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.demo_sec_group.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.demo-private-subnet.id}"

  # Associate with public ip
  associate_public_ip_address = true

  # root block device which need 40G.
  root_block_device {
    volume_type = "standard"
    volume_size = 40
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
