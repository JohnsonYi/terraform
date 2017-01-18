variable "public_key_path" {
  default = "~/.ssh/cq-scf-kick-off.pub"
  description = "Public key path"
}

variable "key_name" {
  default = "cq-scf-kick-off"
  description = "Desired name of AWS key pair"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "cn-north-1"
}

# Ubuntu 16.04 LTS (x64)
variable "aws_amis" {
  default = {
    cn-north-1 = "ami-002efa6d"
  }
}
