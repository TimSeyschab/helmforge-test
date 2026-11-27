resource "random_password" "redis" {
  count = var.redis_password == null ? 1 : 0

  length  = 48
  special = false
}

resource "kubernetes_secret_v1" "redis" {
  metadata {
    name      = var.redis_secret_name
    namespace = kubernetes_namespace_v1.redis.metadata[0].name
  }

  type = "Opaque"
  data = {
    (var.redis_secret_key) = var.redis_password == null ? random_password.redis[0].result : var.redis_password
  }
}

