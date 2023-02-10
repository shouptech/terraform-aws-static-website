module "route53" {
  source    = "../../modules/route53-zone"
  zone_name = var.zone_name
}
