resource "vault_mount" "pki_root" {
  path                      = "pki_root"
  type                      = "pki"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
  description               = "mount point for root CA"
}

resource "vault_pki_secret_backend_root_cert" "test" {
  depends_on           = [vault_mount.pki_root]
  backend              = vault_mount.pki_root.path
  type                 = "internal"
  common_name          = "hashidemo.com"
  ttl                  = "315360000"
  format               = "pem"
  private_key_format   = "der"
  key_type             = "rsa"
  key_bits             = 4096
  exclude_cn_from_sans = true
  ou                   = "hashidemo_ou"
  organization         = "hashidemoorg"
}

resource "vault_pki_secret_backend_role" "root_role" {
  backend            = vault_mount.pki_root.path
  name               = "root_pki_admin"
  ttl                = 8000
  allow_ip_sans      = true
  key_type           = "rsa"
  key_bits           = 4096
  allowed_domains    = ["hashicorp.com"]
  allow_subdomains   = true
  allow_bare_domains = true
}

resource "vault_pki_secret_backend_config_urls" "config_urls" {
  backend                 = vault_mount.pki_root.path
  issuing_certificates    = ["http://127.0.0.1:8200/v1/pki/ca"]
  crl_distribution_points = ["http://127.0.0.1:8200/v1/pki/ca"]
}

resource "vault_mount" "pki_intermediate" {
  path                      = "pki_intermediate"
  type                      = "pki"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
  description               = "mount point for intermedaite CA"
}

resource "vault_pki_secret_backend_intermediate_cert_request" "request" {
  depends_on  = [vault_mount.pki_root]
  backend     = vault_mount.pki_intermediate.path
  type        = "internal"
  common_name = "hashidemo.com Intermediate Authority (IA)"
}

resource "vault_pki_secret_backend_root_sign_intermediate" "root" {
  depends_on           = [vault_pki_secret_backend_intermediate_cert_request.request]
  backend              = vault_mount.pki_root.path
  csr                  = vault_pki_secret_backend_intermediate_cert_request.request.csr
  common_name          = "Intermediate CA"
  exclude_cn_from_sans = true
  ou                   = "My OU"
  organization         = "My organization"
}

resource "vault_pki_secret_backend_intermediate_set_signed" "intermediate" {
  backend     = vault_mount.pki_intermediate.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.root.certificate
}

resource "vault_pki_secret_backend_role" "int_role" {
  backend            = vault_mount.pki_intermediate.path
  name               = "intermediate_pki_admin"
  ttl                = 1000
  allow_ip_sans      = true
  key_type           = "rsa"
  key_bits           = 4096
  allowed_domains    = ["demo.hashicorp.com"]
  allow_subdomains   = true
  allow_bare_domains = true
}