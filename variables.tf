# Project ID
variable "project_id" {
    type = string
    default = "docpet-project-ch2-ps068"
    description = "Project ID <type: String>"
}

# Region
variable "region" {
    type = string
    default = "asia-southeast2"
    description = "Region <type: String>"
}

# Revision Name
# variable "revision_name" {
#     type = string
#     default = "revision-name-xxxx"
#     description = "Revision Name <type: String>"
# }

# Service Name
variable "service_name" {
    type = string
    default = "docpet-backend-service"
    description = "Service Name <type: String>"
}

# Service Account
variable "service_account" {
    type = string
    default = "blablabla@blablabl.com"
    sensitive = true
    description = "Service Account <type: String>"
}

# Service Container
variable "service_container" {
    type = string
    default = "us-docker.pkg.dev/cloudrun/container/hello"
    description = "Service Container <type: String>"
}

# VPC access connector
variable "vpc_access_connector" {
    type = string
    default = "vpc-connector"
    description = "VPC access connector <type: String>"
}

# PostgreSQL Password
variable "postgres_password" {
    type = string
    sensitive = true
    description = "PostgreSQL Password Secret <type: String>"
}

# Postgres Port
variable "postgres_port" {
    type = string
    sensitive = true
    description = "Postgres Port <type: String>"
}

# Postgres User
variable "postgres_user" {
    type = string
    sensitive = true
    description = "Postgres User <type: String>"
}

# Postgres DB
variable "postgres_db" {
    type = string
    sensitive = true
    description = "Postgres DB <type: String>"
}

# Postgres Host
variable "postgres_host" {
    type = string
    sensitive = true
    description = "Postgres Host <type: String>"
}

# Postgres Hostname
variable "postgres_hostname" {
    type = string
    sensitive = true
    description = "Postgres Hostname <type: String>"
}

# Access Token Expires
variable "access_token_expires" {
    type = string
    sensitive = true
    description = "Access Token Expires <type: String>"
}

# Refresh Token Expires
variable "refresh_token_expires" {
    type = string
    sensitive = true
    description = "Refresh Token Expires <type: String>"
}

# JWT Algorithm
variable "jwt_algorithm" {
    type = string
    sensitive = true
    description = "JWT Algorithm <type: String>"
}

# JWT Public Key
variable "jwt_public_key" {
    type = string
    sensitive = true
    description = "Access Token <type: String>"
}

# JWT Private Key
variable "jwt_private_key" {
    type = string
    sensitive = true
    description = "Refresh Token <type: String>"
}
