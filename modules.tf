# PostgreSQL Password Secret
module "pgsql_password_secret" {
    source = "./modules/secrets"
    secret_project_id = var.project_id
    secret_id = "db-password"
    secret_data = var.pgsql_password
}

# Access Token Secret
module "access_token_secret" {
    source = "./modules/secrets"
    secret_project_id = var.project_id
    secret_id = "access-token-secret"
    secret_data = var.access_token
}

# Refresh Token Secret
module "refresh_token_secret" {
    source = "./modules/secrets"
    secret_project_id = var.project_id
    secret_id = "refresh-token-secret"
    secret_data = var.refresh_token
}

# Docpet Backend Service (Cloud Run)
module "docpet_service_cloud_run" {
    source = "./modules/cloud_run"
    cloud_run_name = var.service_name

    cloud_run_project = var.project_id

    cloud_run_description = <<-EOT
        backend service
    EOT

    cloud_run_location = var.region
    cloud_run_ingress  = "INGRESS_TRAFFIC_ALL"

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
        timeout_seconds = 5
        failure_threshold = 5
        initial_delay_seconds = 10
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
        JWT_ALGORITHM = "HS512"
        JWT_ACCESS_TOKEN_EXPIRE = "1"
        JWT_REFRESH_TOKEN_EXPIRE = "7"
        JWT_REFRESH_TOKEN_SECRET = module.refresh_token_secret.secret_id_output
        JWT_ACCESS_TOKEN_SECRET  = module.access_token_secret.secret_id_output

        POSTGRES_DB = "dbname"
        POSTGRES_HOST = "10.8.0.16"
        POSTGRES_PORT = "5432"
        POSTGRES_USER = "postgres"
        POSTGRES_PASS = module.pgsql_password_secret.secret_id_output
    }
}