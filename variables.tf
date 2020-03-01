variable "region" {
    default = "ap-southeast-1"
}

variable "ssh_port"{
    description = "The port the EC2 Instance should listen on for SSH requests."
    default     = 22
}

variable "vault_port"{
    description = "The port the EC2 Instance should listen on for vault requests."
    default     = 8200
}

variable "image_size"{
    description = "The size of the EC2 Instance "
    type        = "string"
    default     = "t2.micro"
}


variable "ssh_user" {
  description = "SSH user name to use for remote exec connections"
  type        = "string"
  default     = "ec2-user"
}

variable "key_name" {
  description = "SSH Private Key"
  type        = "string"
  default     = "~/.ssh/aws-kp.pem"
}

variable "pub_key_name" {
  description = "SSH Public Key"
  type        = "string"
  default     = "aws-kp"
}

variable "profile_name" {
    description = "AWS credential profile which can be found in ~/.aws/credentials"
    type = "string"
    default = "aws-devops"
}