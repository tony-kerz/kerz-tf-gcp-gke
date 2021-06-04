terraform {
  backend "gcs" {}
  required_providers {
    google = {}
  }
}

# to-do: move this to a project setup spot...
#
# resource "google_project_service" "this" {
#   for_each = toset(var.apis)
#   project  = var.project
#   service  = each.value
# }

