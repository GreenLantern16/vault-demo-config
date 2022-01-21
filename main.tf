provider "vault" {
  address = "http://${var.vault_host}:${var.vault_port}"
  token   = var.vault_token
}

provider "vault" {
  address   = "http://${var.vault_host}:${var.vault_port}"
  token     = var.vault_token
  namespace = trimsuffix(vault_namespace.core_infra.id, "/")
  alias     = "core_infra"
}

provider "vault" {
  address   = "http://${var.vault_host}:${var.vault_port}"
  token     = var.vault_token
  namespace = trimsuffix(vault_namespace.database_team.id, "/")
  alias     = "database_team"
}
provider "vault" {
  address   = "http://${var.vault_host}:${var.vault_port}"
  token     = var.vault_token
  namespace = trimsuffix(vault_namespace.web_team.id, "/")
  alias     = "web_team"
}
provider "vault" {
  address   = "http://${var.vault_host}:${var.vault_port}"
  token     = var.vault_token
  namespace = trimsuffix(vault_namespace.high_performance_computing.id, "/")
  alias     = "hpc"
}

provider "vault" {
  address   = "http://${var.vault_host}:${var.vault_port}"
  token     = var.vault_token
  namespace = trimsuffix(vault_namespace.boundary.id, "/")
  alias     = "boundary"
}

provider "vault" {
  address   = "http://${var.vault_host}:${var.vault_port}"
  token     = var.vault_token
  namespace = trimsuffix(vault_namespace.finance.id, "/")
  alias     = "finance"
}

resource "vault_mount" "infra-creds" {
  path        = "infrastructure_creds"
  type        = "kv-v2"
  description = "Infrastructure admin credentials"
}

