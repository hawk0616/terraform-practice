resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "www.example.com"
  type    = "A"

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = false
  }
}