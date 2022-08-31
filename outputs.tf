output "dns_hosted_zone_id" {
  value = aws_route53_zone.private_hosted_zone.id
}

output "dns_hosted_zone_arn" {
  value = aws_route53_zone.private_hosted_zone.arn
}