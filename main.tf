terraform {
    required_version = ">= 1.0"

    required_providers {
        google = {
            source  = "hashicorp/google"
            version = "5.6.0"
        }
    }

    backend "gcs" {
        bucket  = "docpet-terraform-state-store"
    }
}

provider "google" {
    project = var.project_id
    region  = var.region
}
