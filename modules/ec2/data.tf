data "aws_acm_certificate" "main_certificate" {
  domain = var.cert_name
  types  = ["AMAZON_ISSUED"]
}
