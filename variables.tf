variable "tags" {
  type = map(any)
}

variable "clusters" {
  type = map(any)
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

# to-do: move to project-centric tf-project
#
# variable "project" {}

# variable "apis" {
#   type = list(any)
#   default = [
#     "container.googleapis.com"
#   ]
# }
