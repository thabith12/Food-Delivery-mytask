output "task22_ec2_public_ip" {
  value = data.aws_instance.task22_dynamic.public_ip
}

output "task22_ec2_public_dns" {
  value = data.aws_instance.task22_dynamic.public_dns
}

output "static_cloudfront_domain" {
  value = data.aws_cloudfront_distribution.static.domain_name
}

output "dynamic_cloudfront_domain" {
  value = data.aws_cloudfront_distribution.dynamic.domain_name
}
