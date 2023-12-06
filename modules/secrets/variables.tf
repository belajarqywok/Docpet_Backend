# Secret Project ID
variable "secret_project_id" {
    type = string
    description = "Secret Project ID <type: String>"
}

# Secret ID
variable "secret_id" {
    type = string
    default = "secret-aBcDeFg"
    description = "Secret ID <type: String>"
}

# Secret Data (SENSITIVE)
variable "secret_data" {
    type = string
    sensitive = true
    description = "Secret Data (SENSITIVE) <type: String>"
}
