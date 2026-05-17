data "cloudflare_zone" "main" {
  filter = {
    name = "divemap.io"
  }
}

resource "cloudflare_dns_record" "main" {
  for_each = local.dns_records

  zone_id = data.cloudflare_zone.main.id
  name    = each.value.name
  content = each.value.content
  type    = "CNAME"
  ttl     = 1
  proxied = true
}
