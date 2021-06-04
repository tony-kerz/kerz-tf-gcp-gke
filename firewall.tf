# to-do: where to do this? firewall rule required for nginx-ingress?
#

# resource "google_compute_firewall" "this" {
#   name = local.name
#   # project   = var.network_project_id
#   network   = data.google_compute_network.this.self_link
#   direction = "INGRESS"
#   priority  = 2000

#   allow {
#     protocol = "tcp"
#     ports    = ["8443"]
#   }

#   source_ranges = [local.master-cidr]
# }

#
# Error: Error creating Firewall: googleapi: Error 400: Invalid value for field 'resource.network': 'projects/kerz-shared/global/networks/kerz-shared'.
# Cross project referencing is not allowed for this resource., invalid
