# Cloud Run Service Name Output
output "cloud_run_service_name_output" {
    value = google_cloud_run_v2_service.cloud_run_service.name
    description = "Cloud Run Service Name Output <type: String>"
}