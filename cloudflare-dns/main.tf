terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"   # pick the latest stable version
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}


resource "cloudflare_dns_record" "traefik" {
  zone_id = var.cloudflare_zone_id
  name    = "traefik"           
  type    = "A"                 
  content   = var.target_ip
  ttl     = 300
  proxied = false               
}

resource "cloudflare_dns_record" "uptime" {
  zone_id = var.cloudflare_zone_id
  name    = "uptime"
  type    = "A"
  content   = var.target_ip
  ttl     = 300
  proxied = false
}

resource "cloudflare_dns_record" "romm" {
  zone_id = var.cloudflare_zone_id
  name    = "romm"
  type    = "A"
  content   = var.target_ip
  ttl     = 300
  proxied = false
}