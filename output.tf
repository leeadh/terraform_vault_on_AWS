
# ---------------------------------------------------------------------------------------------------------------------
# OUTPUT THE IP OF THE INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

output "vault_public_url" {
  value = "http://${aws_instance.vault.public_ip}:${var.vault_port}"
}


output "vault_private_url" {
  value = "http://${aws_instance.vault.private_ip}:${var.vault_port}"
}
