variable "project_name" {
  description = "GCP Project ID"
  default = "crisp-demo"
}

variable "credentials_path" {
  description = "Path to GCP Credentials JSON"
}

variable "public_key_path" {
  description = "Path to ssh public key"
}

variable "private_key_path" {
  description = "Path to ssh private key"
}

