# Terraform module for extrernal dns

This module deploys an external dns service an an Amazon EKS cluster. The service will publish DNS records for the EKS cluster to a new Route53 private hosted zone.

## Module input parameters

| Parameter              | Type     | Description                                                                        |
| ---------------------- |--------- | ---------------------------------------------------------------------------------- |
| namespace              | Required | The kubernetes namespace at which the external dns chart will be deployed          |
| eks_cluster_properties | Required | A map variable containing properties of the EKS cluster                            |
| domain                 | Required | The domain of a new Route53 private hosted zone that will be created for the EKS cluster |
| node_selector          | Optional | A map variable with nodeSelector labels applied when placing pods of the chart on the cluster |

The structure of the "eks_cluster_properties" variable is as follows:
```
eks_cluster_properties = {
  vpc_id                      = <ID of the VPC on which the EKS cluster is deployed>
  openid_connect_provider_url = <URL of OpenID connect provider of EKS cluster>
  openid_connect_provider_arn = <ARN of OpenID connect provider of EKS cluster>  
}
```

## Module output parameters

| Parameter                   | Description                                                               |
| --------------------------- | ------------------------------------------------------------------------- |
| dns_hosted_zone_id          | The id of the created Route53 private hosted zone for the cluster         |
| dns_hosted_zone_arn         | The ARN of the created Route53 private hosted zone for the cluster        |