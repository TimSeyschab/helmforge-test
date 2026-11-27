resource "helm_release" "redis" {
  name       = "db"
  namespace  = kubernetes_namespace_v1.redis.metadata[0].name
  repository = "https://repo.helmforge.dev"
  chart      = "redis"
  version    = "3.2.2"

  values = [templatefile("${path.module}/values.tmpl", {
    secret_name = kubernetes_secret_v1.redis.metadata[0].name
    secret_key  = var.redis_secret_key
  })]
}

