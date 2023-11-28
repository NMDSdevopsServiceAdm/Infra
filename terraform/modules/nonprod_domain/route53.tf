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