
resource "vault_namespace" "core_infrastructure" {
  path = "core_infra"
}

resource "vault_namespace" "database" {
  path = "database_team"
}

resource "vault_namespace" "web_team" {
  path = "web_team"
}

resource "vault_namespace" "hcp" {
  path = "high_performance_computing"
}
