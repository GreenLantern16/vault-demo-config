
resource "vault_namespace" "core_infrastructure" {
  path = "core_infra"
}

resource "vault_namespace" "database" {
  path = "database_team"
}

resource "vault_namespace" "web_team" {
  path = "web_team"
}

resource "vault_namespace" "web_test" {
  provider = vault.web_team
  path     = "web_test"
}

resource "vault_namespace" "web_prod" {
  provider = vault.web_team
  path     = "web_prod"
}

resource "vault_namespace" "hcp" {
  path = "high_performance_computing"
}

resource "vault_namespace" "boundary" {
  path = "boundary"
}

resource "vault_namespace" "finance" {
  path = "finance"
}
