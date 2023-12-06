# Secret ID Output
output "secret_id_output" {
    value = google_secret_manager_secret.secret_manager.secret_id
    description = "Secret ID Output <type: String>"
}

# Secret Version Output
output "secret_version_output" {
    value = google_secret_manager_secret_version.secret_manager_version
    description = "Secret Version Output <type: Resource>"
}
