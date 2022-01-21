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


resource "vault_policy" "fpe-client-policy" {
  name   = "fpe-client-policy"
  policy = <<EOT
  path "transform/encode/*" {
   capabilities = [ "update" ]
}

path "transform/decode/*" {
   capabilities = [ "update" ]
}
EOT
}

resource "vault_policy" "admin_policy_finance" {
  provider   = vault.finance
  depends_on = [vault_namespace.finance]
  name       = "admins"
  policy     = file("policies/admin.hcl")
}

resource "vault_policy" "admin-policy" {
  name   = "admin"
  policy = file("policies/admin.hcl")
}