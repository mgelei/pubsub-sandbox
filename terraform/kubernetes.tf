resource "kubernetes_namespace" "rabbitmq-namespace" {
  metadata {
    name = "rabbitmq"
  }
}