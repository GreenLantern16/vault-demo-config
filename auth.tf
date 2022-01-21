resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_generic_endpoint" "admin" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/admin"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["default", "root"],
  "password": "rootrootroot"
}
EOT
}