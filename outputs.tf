output "sentinel_endpoint" {
  value = "db.${var.namespace}.svc:26379"
}

output "sentinel_master_set" {
  value = "mymaster"
}
