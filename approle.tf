resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_policy" "terraform_vmware_read" {
  name   = "terraform_vmware_read"
  policy = <<EOT
path "infrastructure_creds/*" {
  capabilities = [ "read", "list" ]
}

path "auth/token/create" {
capabilities = ["create", "read", "update", "list"]
}
EOT
}

resource "vault_approle_auth_backend_role" "terraform_read" {
  backend        = vault_auth_backend.approle.path
  role_name      = "terraform_read"
  token_policies = ["default", "terraform_vmware_read"]
  token_ttl      = 6000
  token_max_ttl  = 60000
}

resource "vault_approle_auth_backend_role_secret_id" "id" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.terraform_read.role_name
}

resource "vault_approle_auth_backend_login" "login" {
  backend   = vault_auth_backend.approle.path
  role_id   = vault_approle_auth_backend_role.terraform_read.role_id
  secret_id = vault_approle_auth_backend_role_secret_id.id.secret_id
}