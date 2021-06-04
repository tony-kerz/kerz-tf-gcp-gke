locals {
  secondaries = data.google_compute_subnetwork.this.secondary_ip_range
  versions    = data.google_container_engine_versions.this.valid_master_versions
  version = local.versions[
    index(local.versions.*, var.master-version)
  ]
}

data "google_compute_subnetwork" "this" {
  name    = var.subnet.name
  project = var.subnet.project
}

data "google_container_engine_versions" "this" {
  provider       = google-beta
  version_prefix = var.version-prefix
}

resource "google_container_cluster" "this" {
  name               = var.name
  min_master_version = local.version

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  #
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = data.google_compute_subnetwork.this.network
  subnetwork               = data.google_compute_subnetwork.this.self_link

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.subnet.master-cidr
  }

  ip_allocation_policy {
    services_secondary_range_name = "service"
    cluster_secondary_range_name  = "pod"
  }
}

resource "google_container_node_pool" "this" {
  for_each = var.pools

  name       = each.key
  cluster    = google_container_cluster.this.name
  version    = local.version
  node_count = each.value.node-count

  node_config {
    preemptible  = each.value.is-preemtible
    machine_type = each.value.machine-type
  }
}
