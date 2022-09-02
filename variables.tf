variable "namespace" {
  description = "The kubernetes namespace at which the external dns chart will be deployed."
}

variable "eks_cluster_name" {
  description = "The name of the eks cluster at which the external dns chart will be installed."
}

variable "domain" {
  description = "The domain corresponding to a new Route53 private hosted zone for the eks cluster."
}

variable "node_selector" {
  description = "A map variable with nodeSelector labels applied when placing pods of the chart on the cluster."
  default     = {}
}