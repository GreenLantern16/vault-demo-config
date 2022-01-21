resource "vault_mount" "databases" {
  path = "databases"
  type = "database"
}

resource "vault_database_secret_backend_connection" "northwind_connection" {
  backend       = vault_mount.databases.path
  name          = "postgres"
  allowed_roles = ["dba", "analyst"]

  postgresql {
    connection_url       = "postgresql://${var.psql_user}:${var.psql_pw}@${var.psql_host}:${var.psql_port}/${var.root_db}?sslmode=disable"
    max_idle_connections = 100
  }
}

resource "vault_database_secret_backend_role" "analyst_role" {
  backend     = vault_mount.databases.path
  name        = "analyst"
  db_name     = vault_database_secret_backend_connection.northwind_connection.name
  default_ttl = 300
  max_ttl     = 3000
  creation_statements = [
    "create role \"{{name}}\" with login password '{{password}}' valid until '{{expiration}}' inherit;",
  "grant northwind_analyst to \"{{name}}\";"]
}

resource "vault_database_secret_backend_role" "dba_role" {
  backend     = vault_mount.databases.path
  name        = "dba"
  db_name     = vault_database_secret_backend_connection.northwind_connection.name
  default_ttl = 300
  max_ttl     = 3000
  creation_statements = ["create role \"{{name}}\" with login password '{{password}}' valid until '{{expiration}}' inherit;",
  "grant northwind_dba to \"{{name}}\";"]
}