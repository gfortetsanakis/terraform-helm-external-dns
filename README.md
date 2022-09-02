# Terraform module for extrernal dns

This module deploys an external dns service an an Amazon EKS cluster. The service will publish DNS records for the eks cluster to a new Route53 private hosted zone.

## Module input parameters

| Parameter                      | Type     | Description                                                                        |
| ------------------------------ |--------- | ---------------------------------------------------------------------------------- |
| namespace                      | Required | The kubernetes namespace at which the external dns chart will be deployed          |
| eks_cluster_name               | Required | The name of the eks cluster at which the external dns chart will be installed      |
| domain                         | Required | The domain of a new Route53 private hosted zone that will be created for the eks cluster |
| node_selector                  | Optional | A map variable with nodeSelector labels applied when placing pods of the chart on the cluster |

## Module output parameters

| Parameter                   | Description                                                               |
| --------------------------- | ------------------------------------------------------------------------- |
| dns_hosted_zone_id          | The id of the created Route53 private hosted zone for the cluster         |
| dns_hosted_zone_arn         | The ARN of the created Route53 private hosted zone for the cluster        |