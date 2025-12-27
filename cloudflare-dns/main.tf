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


resource "cloudflare_dns_record" "immich" {
  zone_id = var.cloudflare_zone_id
  name    = "immich"
  type    = "A"
  content   = var.target_ip
  ttl     = 300
  proxied = false
}
resource "cloudflare_dns_record" "glance" {
  zone_id = var.cloudflare_zone_id
  name    = "glance"
  type    = "A"
  content   = var.target_ip
  ttl     = 300
  proxied = false
}

resource "cloudflare_dns_record" "code-server" {
  zone_id = var.cloudflare_zone_id
  name    = "code-server"
  type    = "A"
  content   = var.target_ip
  ttl     = 300
  proxied = false
}

resource "cloudflare_dns_record" "jellyfin" {
  zone_id = var.cloudflare_zone_id
  name    = "jellyfin"
  type    = "A"
  content   = var.target_ip
  ttl     = 300
  proxied = false
}

resource "cloudflare_dns_record" "lidarr" {
  zone_id = var.cloudflare_zone_id
  name    = "lidarr"
  type    = "A"
  content   = var.target_ip
  ttl     = 300
  proxied = false
}

resource "cloudflare_dns_record" "lidatube" {
  zone_id = var.cloudflare_zone_id
  name    = "lidatube"
  type    = "A"
  content   = var.target_ip
  ttl     = 300
  proxied = false
}

resource "cloudflare_dns_record" "n8n" {
  zone_id = var.cloudflare_zone_id
  name    = "n8n"
  type    = "A"
  content   = var.target_ip
  ttl     = 300
  proxied = false
}
resource "cloudflare_dns_record" "paperless" {
  zone_id = var.cloudflare_zone_id
  name    = "paperless"
  type    = "A"
  content   = var.target_ip
  ttl     = 300
  proxied = false
}