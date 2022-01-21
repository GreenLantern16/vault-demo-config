resource "vault_policy" "northwind_db_policy" {
  name   = "northwind_db_policy"
  policy = <<EOT
path "psql/creds/analyst" {
  capabilities = ["read"]
}

path "psql/creds/dba" {
  capabilities = ["read"]
}
EOT
}