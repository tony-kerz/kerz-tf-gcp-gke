# beware: https://github.com/hashicorp/terraform-provider-google/issues/1711
#
# resource "google_project_iam_binding" "this" {
#   project = local.shared
#   role    = "roles/compute.networkUser"

#   members = [
#     "serviceAccount:${local.name}@${local.name}.iam.gserviceaccount.com"
#   ]
# }
