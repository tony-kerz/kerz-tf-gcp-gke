output "network" {
  value = data.google_compute_network.this
}

output "subnet" {
  value = data.google_compute_subnetwork.this
}

# output "cluster" {
#   value = google_container_cluster.this
# }

output "versions" {
  value = data.google_container_engine_versions.this
}
