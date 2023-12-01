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
  comment = "Managed by Terraform"
}

resource "aws_route53_record" "staging_ascwds_co_uk" {
  zone_id = aws_route53_zone.ascwds_co_uk_zone.zone_id
  name    = "staging"
  type    = "CNAME"
  ttl     = 300
  records = ["d100lf5hrbnpno.cloudfront.net"]
}

resource "aws_route53_record" "cert_validation_record_staging_ascwds_co_uk" {
  zone_id = aws_route53_zone.ascwds_co_uk_zone.zone_id
  name    = "_4a84c95f3c07d554ee0dafc8f8d28eb8.staging.ascwds.co.uk."
  type    = "CNAME"
  ttl     = 300
  records = ["_9e3f4f98316eeb44fc84618804851f0c.mhbtsbpdnt.acm-validations.aws."]
}

resource "aws_route53_record" "preprod_ascwds_co_uk" {
  zone_id = aws_route53_zone.ascwds_co_uk_zone.zone_id
  name    = "preprod"
  type    = "CNAME"
  ttl     = 300
  records = ["duttt3okuv0ou.cloudfront.net"]

}

resource "aws_route53_record" "cert_validation_record_preprod_ascwds_co_uk" {
  zone_id = aws_route53_zone.ascwds_co_uk_zone.zone_id
  name    = "_30c1b7b2068c05bc544133affd4cab00.preprod.ascwds.co.uk."
  type    = "CNAME"
  ttl     = 300
  records = ["_e109630450ce8fda3e87687c37a25b80.mhbtsbpdnt.acm-validations.aws."]
}

resource "aws_route53_record" "benchmarks_ascwds_co_uk" {
  zone_id = aws_route53_zone.ascwds_co_uk_zone.zone_id
  name    = "benchmarks"
  type    = "CNAME"
  ttl     = 300
  records = ["d184ukjoa59eiv.cloudfront.net"]
}

resource "aws_route53_record" "cert_validation_record_benchmarks_ascwds_co_uk" {
  zone_id = aws_route53_zone.ascwds_co_uk_zone.zone_id
  name    = "_966bf319c75e57e85e3caec3e40ba32c.benchmarks.ascwds.co.uk."
  type    = "CNAME"
  ttl     = 300
  records = ["_334fa43a80198dbbbafa7e64e5f212f3.mhbtsbpdnt.acm-validations.aws."]
}