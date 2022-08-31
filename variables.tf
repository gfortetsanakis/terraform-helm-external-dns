variable "namespace" {
  description = "The kubernetes namespace at which the external dns chart will be deployed."
}

variable "domain" {
  description = "The domain corresponding to a new Route53 private hosted zone for the eks cluster."
}

variable "vpc_id" {
  description = "The id of the VPC at which the eks cluster has been installed."
}

variable "openid_connect_provider_arn" {
  description = "The ARN of the OpenID connect provider of the eks cluster."
}

variable "openid_connect_provider_url" {
  description = "The URL of the OpenID connect provider of the eks cluster."
}

variable "node_selector" {
  description = "A map variable with nodeSelector labels applied when placing pods of the chart on the cluster."
  default     = {}
}