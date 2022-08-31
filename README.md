# Terraform module for extrernal dns

This module deploys an external dns service an an Amazon EKS cluster. The service will publish DNS records for the eks cluster to a new Route53 private hosted zone.

## Module input parameters

| Parameter                      | Type     | Description                                                                        |
| ------------------------------ |--------- | ---------------------------------------------------------------------------------- |
| namespace                      | Required | TThe kubernetes namespace at which the external dns chart will be deployed         |
| domain                         | Required | The domain corresponding to a new Route53 private hosted zone for the eks cluster  |
| vpc_id                         | Required | The id of the VPC at which the eks cluster has been installed                      |
| openid_connect_provider_arn    | Required | The ARN of the OpenID connect provider of the eks cluster                          |
| openid_connect_provider_url    | Required | The URL of the OpenID connect provider of the eks cluster                          |
| node_selector                  | Optional | A map variable with nodeSelector labels applied when placing pods of the chart on the cluster |

## Module output parameters

| Parameter                   | Description                                                               |
| --------------------------- | ------------------------------------------------------------------------- |
| dns_hosted_zone_id          | The id of the created Route53 private hosted zone for the cluster         |
| dns_hosted_zone_arn         | The ARN of the created Route53 private hosted zone for the cluster        |