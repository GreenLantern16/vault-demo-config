resource "vault_mount" "ssh" {
  type        = "ssh"
  path        = "ssh"
  description = "engine for managing privileged ssh sessions"
}

resource "vault_ssh_secret_backend_role" "bar" {
  name          = "root"
  backend       = vault_mount.ssh.path
  key_type      = "otp"
  default_user  = "hashicadmin"
  allowed_users = "hashiadmin,hashiroot"
  cidr_list     = "0.0.0.0/0"
}