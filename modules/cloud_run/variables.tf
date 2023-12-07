# Cloud Run Name
variable "cloud_run_name" {
    type = string
    default = "cloud_run_service"
    description = "Cloud Run Name <type: String>"
}

# Cloud Run Project ID
variable "cloud_run_project" {
    type = string
    description = "Cloud Run Project ID <type: String>"
}

# Cloud Run Description
variable "cloud_run_description" {
    type = string
    default = <<-EOT
        this is service for blablabla
    EOT

    description = "Cloud Run Description <type: String>"
}

# Cloud Run Location
variable "cloud_run_location" {
    type = string
    default = "asia-southeast2"
    description = "Cloud Run Location <type: String>"
}

# Cloud Run Ingress
variable "cloud_run_ingress" {
    type = string
    default = "INGRESS_TRAFFIC_ALL"
    description = "value"
}

# Cloud Run Revision
variable "cloud_run_revision" {
    type = string
    default = "revision-service-xxxxx"
    description = "Cloud Run Revision <type: String>"
}

# Cloud Run Service Account
variable "cloud_run_service_account" {
    type = string
    description = "Cloud Run Service Account <type: String>"
}

# Cloud Run Container Image
variable "cloud_run_image" {
    type = string
    default = "us-docker.pkg.dev/cloudrun/container/hello"
    description = "Cloud Run Container Image <type: String>"
}

# Cloud Run Port
variable "cloud_run_port" {
    type = number
    default = 80
    description = "Cloud Run Port <type: Number>"
}

# Cloud Run vCPU Limit
variable "cloud_run_cpu" {
    type = string
    default = "2m"
    description = "Cloud Run vCPU limit <type: String>"
}

# Cloud Run Memory Limit
variable "cloud_run_memory" {
    type = string
    default = "2Gi"
    description = "Cloud Run Memory Limit <type: String>"
}

# Cloud Run CPU Idle
variable "cloud_run_cpu_idle" {
    type = bool
    default = true
    description = "Cloud Run CPU Idle <type: Bool>"
}

# Cloud Run StartUp CPU Boost
variable "cloud_run_cpu_boost" {
    type = bool
    default = true
    description = "Cloud Run StartUp CPU Boost <type: String>"
}

# Cloud Run StartUp Probe
variable "cloud_run_startup_probe" {
    type = map(any)

    default = {
        http_path = "/"
        http_port = 80

        period_seconds = 240
        timeout_seconds = 5
        failure_threshold = 5
        initial_delay_seconds = 10
    }

    description =<<-EOT
        Cloud Run StartUp Probe <type: Map(Any)>
        Example: 
           cloud_run_startup_probe = {
             http_path = "/"
             http_port = 80

             period_seconds = 240
             timeout_seconds = 5
             failure_threshold = 5
             initial_delay_seconds = 10
           } 
    EOT
}

# Cloud Run Liveness Probe
variable "cloud_run_liveness_probe" {
    type = map(any)

    default = {
        http_path = "/"
        http_port = 80

        period_seconds = 240
        timeout_seconds = 5
        failure_threshold = 5
        initial_delay_seconds = 10
    }

    description =<<-EOT
        Cloud Run Liveness Probe <type: Map(Any)>
        Example: 
           cloud_run_startup_probe {
             http_path = "/"
             http_port = 80

             period_seconds = 240
             timeout_seconds = 5
             failure_threshold = 5
             initial_delay_seconds = 10
           } 
    EOT
}

# Cloud Run Timeout
variable "cloud_run_timeout" {
    type = number
    default = 800
    description = "Cloud Run Timeout <type: Number>"
}

# Cloud Run Max Instance Request Concurrency
variable "cloud_run_max_instance_concurrent" {
    type = number
    default = 80
    description = "Cloud Run Max Instance Request Concurrency <type: Number>"
}

# Cloud Run Execution Environment
variable "cloud_run_execution_environment" {
    type = string
    default = "EXECUTION_ENVIRONMENT_GEN1"
    description = "Cloud Run Execution Environment <type: String>"
}

# Cloud Run Min Instance
variable "cloud_run_min_instance" {
    type = number
    default = 0
    description = "Cloud Run Min Instance <type: Number>"
}

# Cloud Run Max Instance
variable "cloud_run_max_instance" {
    type = number
    default = 15
    description = "Cloud Run Max Instance <type: Number>"
}

# Cloud Run Traffic Percent
variable "cloud_run_traffic_percent" {
    type = number
    default = 100
    description = "Cloud Run Traffic Percent <type: Number>"
}

# Cloud Run Traffic Type
variable "cloud_run_traffic_type" {
    type = string
    default = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    description = "Cloud Run Traffic Type <type: String>"
}

# Cloud Run Connector
variable "cloud_run_vpc_access_connector" {
    type = string
    default = "project-vpc-connector"
    description = "Cloud Run Connector <type: String>"
}

# Cloud Run VPC Access Egress
variable "cloud_run_vpc_access_egress" {
    type = string
    default = "ALL_TRAFFIC"
    description = "Cloud Run VPC Access Egress <type: String>"
}

# Cloud Run Environment Variables
variable "cloud_run_envars" {
    type = map(string)
    sensitive = true

    default = {
        DATABASE_PORT = "5432"
        POSTGRES_USER = "postgres"
        POSTGRES_DB = "dbname"
        POSTGRES_HOST = "postgres"
        POSTGRES_HOSTNAME = "127.0.0.1"

        ACCESS_TOKEN_EXPIRES_IN = "15"
        REFRESH_TOKEN_EXPIRES_IN = "60"
        JWT_ALGORITHM = "RS256"
        CLIENT_ORIGIN = "*"

        JWT_PUBLIC_KEY = "<jwt public key>"
        JWT_PRIVATE_KEY = "<jwt private key>"
        POSTGRES_PASSWORD = "secret value"
    }

    description =<<-EOT
        Cloud Run Environment Variables <type: map(String)>
        Example:
            cloud_run_envars = {
                DATABASE_PORT = "5432"
                POSTGRES_USER = "postgres"
                POSTGRES_DB = "docpet"
                POSTGRES_HOST = "postgres"
                POSTGRES_HOSTNAME = "127.0.0.1"

                ACCESS_TOKEN_EXPIRES_IN = "15"
                REFRESH_TOKEN_EXPIRES_IN = "60"
                JWT_ALGORITHM = "RS256"
                CLIENT_ORIGIN = "*"

                JWT_PUBLIC_KEY = "<jwt public key>"
                JWT_PRIVATE_KEY = "<jwt private key>"
                POSTGRES_PASSWORD = "secret value"
            }
    EOT
}
