resource "kubernetes_namespace_v1" "redis" {
  metadata {
    name = var.namespace
  }
}

