module "gke" {
  source   = "./module/gke"
  for_each = var.clusters
  name     = each.key
  subnet   = each.value.subnet
  pools    = lookup(each.value, "pools", var.pools)
  labels   = var.tags
}
