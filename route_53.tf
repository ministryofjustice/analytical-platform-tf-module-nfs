data "aws_route53_zone" "selected" {
  zone_id = var.zone_id
}

resource "aws_route53_record" "occm" {
  name    = format("%s.%s", var.name, data.aws_route53_zone.selected.name)
  type    = "A"
  ttl     = "60"
  zone_id = data.aws_route53_zone.selected.zone_id
  records = [aws_eip.occm.public_ip]
}

resource "aws_route53_record" "occm_nfs" {
  name    = format("%s.%s", "nfs-server", data.aws_route53_zone.selected.name)
  type    = "A"
  ttl     = "60"
  zone_id = data.aws_route53_zone.selected.zone_id
  records = [aws_instance.occm.private_ip]
}
