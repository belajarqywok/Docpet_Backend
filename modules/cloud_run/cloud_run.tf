# Cloud Run Service
resource "google_cloud_run_v2_service" "cloud_run_service" {
    name = var.cloud_run_name
    project = var.cloud_run_project
    description = var.cloud_run_description

    location = var.cloud_run_location
    ingress = var.cloud_run_ingress

    template {
        # revision = var.cloud_run_revision
        service_account = var.cloud_run_service_account

        containers {
            image = var.cloud_run_image

            ports {
                container_port = var.cloud_run_port
            }
            
            resources {
                limits = {
                    cpu = var.cloud_run_cpu
                    memory = var.cloud_run_memory
                }

                cpu_idle = var.cloud_run_cpu_idle
                startup_cpu_boost = var.cloud_run_cpu_boost
            }

            # startup_probe {
            #     period_seconds = var.cloud_run_startup_probe["period_seconds"]
            #     timeout_seconds = var.cloud_run_startup_probe["timeout_seconds"]
            #     failure_threshold = var.cloud_run_startup_probe["failure_threshold"]
            #     initial_delay_seconds = var.cloud_run_startup_probe["initial_delay_seconds"]

            #     http_get {
            #         path = var.cloud_run_startup_probe["http_path"]
            #         port = var.cloud_run_startup_probe["http_port"]
            #     }
            # }

            liveness_probe {
                period_seconds = var.cloud_run_liveness_probe["period_seconds"]
                timeout_seconds = var.cloud_run_liveness_probe["timeout_seconds"]
                failure_threshold = var.cloud_run_liveness_probe["failure_threshold"]
                initial_delay_seconds = var.cloud_run_liveness_probe["initial_delay_seconds"]

                http_get {
                    path = var.cloud_run_liveness_probe["http_path"]
                    port = var.cloud_run_liveness_probe["http_port"]
                }
            }

            # Environment Variables
            env {
                name = "DATABASE_PORT"
                value = var.cloud_run_envars["DATABASE_PORT"]
            }

            env {
                name = "POSTGRES_USER"
                value = var.cloud_run_envars["POSTGRES_USER"]
            }

            env {
                name = "POSTGRES_DB"
                value = var.cloud_run_envars["POSTGRES_DB"]
            }

            env {
                name = "POSTGRES_HOST"
                value = var.cloud_run_envars["POSTGRES_HOST"]
            }

            env {
                name = "POSTGRES_HOSTNAME"
                value = var.cloud_run_envars["POSTGRES_HOSTNAME"]
            }

            env {
                name = "ACCESS_TOKEN_EXPIRES_IN"
                value = var.cloud_run_envars["ACCESS_TOKEN_EXPIRES_IN"]
            }

            env {
                name = "REFRESH_TOKEN_EXPIRES_IN"
                value = var.cloud_run_envars["REFRESH_TOKEN_EXPIRES_IN"]
            }

            env {
                name = "JWT_ALGORITHM"
                value = var.cloud_run_envars["JWT_ALGORITHM"]
            }

            env {
                name = "CLIENT_ORIGIN"
                value = var.cloud_run_envars["CLIENT_ORIGIN"]
            }


            # Secrets
            env {
                name = "JWT_PUBLIC_KEY"
                value_source {
                    secret_key_ref {
                        # secret = google_secret_manager_secret.secret.secret_id
                        secret = var.cloud_run_envars["JWT_PUBLIC_KEY"]
                        version = "1"
                    }
                }
            }

            env {
                name = "JWT_PRIVATE_KEY"
                value_source {
                    secret_key_ref {
                        # secret = google_secret_manager_secret.secret.secret_id
                        secret = var.cloud_run_envars["JWT_PRIVATE_KEY"]
                        version = "1"
                    }
                }
            }

            env {
                name = "POSTGRES_PASSWORD"
                value_source {
                    secret_key_ref {
                        # secret = google_secret_manager_secret.secret.secret_id
                        secret = var.cloud_run_envars["POSTGRES_PASSWORD"]
                        version = "1"
                    }
                }
            }
        }

        timeout = "${
            var.cloud_run_timeout
        }s"

        max_instance_request_concurrency = var.cloud_run_max_instance_concurrent
        execution_environment = var.cloud_run_execution_environment

        scaling {
            min_instance_count = var.cloud_run_min_instance
            max_instance_count = var.cloud_run_max_instance
        }

        vpc_access {
            # projects/{project}/locations/{location}/connectors/{connector}
            connector = "projects/${
                var.cloud_run_project
            }/locations/${
                var.cloud_run_location
            }/connectors/${
                var.cloud_run_vpc_access_connector
            }"

            egress = var.cloud_run_vpc_access_egress
        }
    }

    traffic {
        percent = var.cloud_run_traffic_percent
        type = var.cloud_run_traffic_type
    }
}
