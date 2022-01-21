
variable "psql_port" {
  description = "port the vault and boundary servers will use to connect to the psql server"
  default     = 5432
}

variable "psql_user" {
  description = "service account for vault to connect to the psql server"
  default     = "postgres"
}

variable "psql_pw" {
  description = "service account password for vault to connect to the psql server"
  default     = "postgres"
}
variable "psql_host" {
  description = "internal ip or hostname of the psql server"
  default     = "psql"
}

variable "root_db" {
  description = "the master db of the psql server for the vault connection"
  default     = "postgres"
}

variable "vault_host" {
  description = "ip or hostname of the vault server"
  default     = "localhost"
}

variable "vault_port" {
  description = "the configured port to connect to the vault server"
  default     = 8200
}

variable "vault_token" {
  default = "root"
}