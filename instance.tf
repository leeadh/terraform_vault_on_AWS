
# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE EC2 WITH THE VAULT SOFTWARE INSTALLED
# ---------------------------------------------------------------------------------------------------------------------

provider "aws" {
  region="${var.region}"
  profile = "${var.profile_name}"
}

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE EC2 INSTANCE WITH A PUBLIC IP
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "vault" {
  ami                    = "${data.aws_ami.ec2_ami.id}"
  instance_type          = "${var.image_size}"
  security_groups        = ["${aws_security_group.vault-ingress.name}"]
  key_name               = "${var.pub_key_name}"

  # This EC2 Instance has a public IP and will be accessible directly from the public Internet
  associate_public_ip_address = true

}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A SECURITY GROUP TO CONTROL WHAT REQUESTS CAN GO IN AND OUT OF THE VAULT INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "vault-ingress" {
  name = "vault-ingress"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.ssh_port}"
    to_port   = "${var.ssh_port}"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "${var.vault_port}"
    to_port   = "${var.vault_port}"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Provision the server using remote-exec
# ---------------------------------------------------------------------------------------------------------------------

resource "null_resource" "example_provisioner" {
  triggers = {
    public_ip = "${aws_instance.vault.public_ip}"
  }

  connection {
    type  = "ssh"
    host  = "${aws_instance.vault.public_ip}"
    private_key = "${file("${var.key_name}")}"
    user  = "${var.ssh_user}"
    port  = "${var.ssh_port}"
    agent = true
  }

  provisioner "file" {
    source      = "files/vault.service"
    destination = "/tmp/vault.service"
  }

  provisioner "file" {
    source      = "files/vault.hcl"
    destination = "/tmp/vault.hcl"
  }


  // change permissions to executable and pipe its output into a new file
  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/vault.service /etc/systemd/system/vault.service",
      "cd /opt/ && sudo curl -o vault.zip  https://releases.hashicorp.com/vault/1.1.2/vault_1.1.2_linux_amd64.zip",
      "sudo unzip vault.zip",
      "sudo mv vault /usr/bin/",
      "sudo useradd --system --home /etc/vault.d --shell /bin/false vault",
      "sudo mkdir /etc/vault.d",
      "sudo chown -R vault:vault /etc/vault.d",
      "sudo mkdir /vault-data",
      "sudo chown -R vault:vault /vault-data",
      "sudo mkdir -p /logs/vault/",
      "sudo cp /tmp/vault.hcl /etc/vault.d/vault.hcl",
      "sudo systemctl enable vault",
      "sudo systemctl start vault",
      "sudo systemctl status vault"
      
    ]
  }

}

# ---------------------------------------------------------------------------------------------------------------------
# LOOK UP THE LATEST EC2 AMI
# ---------------------------------------------------------------------------------------------------------------------

data "aws_ami" "ec2_ami" {
  most_recent = true
  owners=["amazon"]
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}