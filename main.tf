provider "vault" {
  address = "http://${var.vault_host}:${var.vault_port}"
  token   = var.vault_token
}

resource "vault_mount" "infra-creds" {
  path        = "infrastructure_creds"
  type        = "kv-v2"
  description = "Infrastructure admin credentials"
}

