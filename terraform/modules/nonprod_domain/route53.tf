resource "aws_route53domains_registered_domain" "ascwds_co_uk" {
  domain_name = "ascwds.co.uk"

  name_server {
    name = "ns-1193.awsdns-21.org"
  }

  name_server {
    name = "ns-1865.awsdns-41.co.uk"
  }

  name_server {
    name = "ns-741.awsdns-28.net"
  }

  name_server {
    name = "ns-484.awsdns-60.com"
  }
}

resource "aws_route53_zone" "ascwds_co_uk_zone" {
  name = aws_route53domains_registered_domain.ascwds_co_uk.id
}

resource "aws_route53_record" "staging_ascwds_co_uk" {
  zone_id = aws_route53_zone.ascwds_co_uk_zone.zone_id
  name    = "staging"
  type    = "CNAME"
  ttl     = 300
  records = ["d100lf5hrbnpno.cloudfront.net"]
}

# resource "aws_route53_record" "preprod_ascwds_co_uk" {
#   zone_id = aws_route53_zone.ascwds_co_uk_zone.zone_id
#   name    = "preprod.${aws_route53domains_registered_domain.ascwds_co_uk.id}"
#   type    = "CNAME"
#   ttl     = 300
#   records = [aws_eip.lb.public_ip]
# }

# resource "aws_route53_record" "benchmarks_ascwds_co_uk" {
#   zone_id = aws_route53_zone.ascwds_co_uk_zone.zone_id
#   name    = "preprod.${aws_route53domains_registered_domain.ascwds_co_uk.id}"
#   type    = "CNAME"
#   ttl     = 300
#   records = [aws_eip.lb.public_ip]
# }