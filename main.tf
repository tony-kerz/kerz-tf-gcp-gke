terraform {
  backend "gcs" {}
  required_providers {
    google-beta = {
      version = "~> 3.66.1"
    }
  }
}

provider "google" {
  #project = local.name
  region = var.region
}

locals {
  env    = terraform.workspace
  name   = "${var.tenant}-${local.env}"
  shared = "${var.tenant}-shared"
}

resource "google_project_service" "this" {
  for_each = toset(var.apis)
  project  = local.name
  service  = each.value
}





