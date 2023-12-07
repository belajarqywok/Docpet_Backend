# PostgreSQL Password Secret
module "postgres_password_secret" {
    source = "./modules/secrets"
    secret_project_id = var.project_id
    secret_id = "postgres-password-secret"
    secret_data = var.postgres_password
}

# JWT Public Key Secret
module "public_key_secret" {
    source = "./modules/secrets"
    secret_project_id = var.project_id
    secret_id = "public-key-secret"
    secret_data = var.jwt_public_key
}

# JWT Private Key Secret
module "private_key_secret" {
    source = "./modules/secrets"
    secret_project_id = var.project_id
    secret_id = "private-key-secret"
    secret_data = var.jwt_private_key
}

# Docpet Backend Service (Cloud Run)
module "docpet_service_cloud_run" {
    source = "./modules/cloud_run"
    cloud_run_name = var.service_name

    cloud_run_project = var.project_id

    cloud_run_description = <<-EOT
        Docpet Backend Service
    EOT

    cloud_run_location = var.region
    cloud_run_ingress  = "INGRESS_TRAFFIC_ALL"

    # cloud_run_revision = var.revision_name

    cloud_run_service_account = var.service_account
    
    cloud_run_image = var.service_container
    cloud_run_port  = 80

    cloud_run_cpu = "4.0"
    cloud_run_memory = "4Gi"
    cloud_run_cpu_idle = true
    cloud_run_cpu_boost = true

    cloud_run_startup_probe = {
        http_path = "/api/checker"
        http_port = 80

        period_seconds = 240
        timeout_seconds = 240
        failure_threshold = 20
        initial_delay_seconds = 240
    }

    cloud_run_liveness_probe = {
        http_path = "/api/checker"
        http_port = 80

        period_seconds = 240
        timeout_seconds = 5
        failure_threshold = 5
        initial_delay_seconds = 10
    }

    cloud_run_timeout = 800
    cloud_run_max_instance_concurrent = 80
    cloud_run_execution_environment = "EXECUTION_ENVIRONMENT_GEN1"

    cloud_run_min_instance = 0
    cloud_run_max_instance = 15

    cloud_run_traffic_percent = 100
    cloud_run_traffic_type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"

    cloud_run_vpc_access_connector = var.vpc_access_connector
    cloud_run_vpc_access_egress = "PRIVATE_RANGES_ONLY"

    cloud_run_envars = {
        DATABASE_PORT = var.postgres_port
        POSTGRES_USER = var.postgres_user
        POSTGRES_DB = var.postgres_db
        POSTGRES_HOST = var.postgres_host
        POSTGRES_HOSTNAME = var.postgres_hostname

        ACCESS_TOKEN_EXPIRES_IN = var.access_token_expires
        REFRESH_TOKEN_EXPIRES_IN = var.refresh_token_expires
        JWT_ALGORITHM = var.jwt_algorithm
        CLIENT_ORIGIN = "*"

        JWT_PUBLIC_KEY = module.public_key_secret.secret_id_output
        JWT_PRIVATE_KEY = module.private_key_secret.secret_id_output
        POSTGRES_PASSWORD = module.postgres_password_secret.secret_id_output
    }
}

# Cloud Run Service IAM
resource "google_cloud_run_service_iam_binding" "cloud_run_service_iam" {
    project = var.project_id
    location = var.region
    service = module.docpet_service_cloud_run.cloud_run_service_name_output
    role = "roles/run.invoker"
    members = ["allUsers"]
}
