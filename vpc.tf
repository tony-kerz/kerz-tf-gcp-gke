data "google_compute_network" "this" {
  name    = local.shared
  project = local.shared
}

data "google_compute_subnetwork" "this" {
  #name = "${local.shared}-k8s"
  self_link = "https://www.googleapis.com/compute/v1/projects/kerz-shared/regions/us-east4/subnetworks/kerz-lab-k8s"
  #region    = var.region
  project = local.shared
}

# beware: https://github.com/hashicorp/terraform-provider-google/issues/1711
#
# resource "google_project_iam_binding" "this" {
#   project = local.shared
#   role    = "roles/compute.networkUser"

#   members = [
#     "serviceAccount:${local.name}@${local.name}.iam.gserviceaccount.com"
#   ]
# }
