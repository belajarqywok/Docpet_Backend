data "google_project" "project" {
    project_id = var.secret_project_id
}

resource "google_secret_manager_secret" "secret_manager" {
    secret_id = var.secret_id
    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "secret_manager_version" {
    secret = google_secret_manager_secret.secret_manager.name
    secret_data = var.secret_data
}

resource "google_secret_manager_secret_iam_member" "secret_manager_iam_member" {
    secret_id = google_secret_manager_secret.secret_manager.id
    member = "serviceAccount:${
        data.google_project.project.number
    }-compute@developer.gserviceaccount.com"

    role = "roles/secretmanager.secretAccessor"

    depends_on = [
        google_secret_manager_secret.secret_manager
    ]
}
