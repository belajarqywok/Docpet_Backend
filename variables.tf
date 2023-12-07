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

# PostgreSQL Password
variable "pgsql_password" {
    type = string
    sensitive = true
    description = "PostgreSQL Password Secret <type: String>"
}

# Access Token
variable "access_token" {
    type = string
    sensitive = true
    description = "Access Token <type: String>"
}

# Refresh Token
variable "refresh_token" {
    type = string
    sensitive = true
    description = "Refresh Token <type: String>"
}

# Service Name
variable "service_name" {
    type = string
    default = "backend-service"
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
