variable "labels" {
  type = map(any)
}

variable "name" {}

variable "apis" {
  type = list(any)
  default = [
    "cloudresourcemanager.googleapis.com",
    "container.googleapis.com"
  ]
}

variable "pools" {
  type = map(any)
  default = {
    blue = {
      node-count    = 1
      is-preemtible = true
      machine-type  = "e2-standard-2"
    }
  }
}

variable "version-prefix" {
  default = "1.19."
}

variable "master-version" {
  default = "1.19.9-gke.1400"
}

variable "subnet" {
  type = map(any)
}
