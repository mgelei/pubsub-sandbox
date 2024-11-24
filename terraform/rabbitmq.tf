resource "helm_release" "rabbitmq_operator" {
  name       = "rabbitmq-operator"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "rabbitmq-cluster-operator"
  version    = "4.3.27"
  namespace  = "rabbitmq"

  set {
    name  = "clusterOperator.tolerations[0].key"
    value = "CriticalAddonsOnly"
  }
  set {
    name  = "clusterOperator.tolerations[0].operator"
    value = "Exists"
  }
  set {
    name  = "clusterOperator.tolerations[0].effect"
    value = "NoExecute"
  }

  set {
    name  = "msgTopologyOperator.tolerations[0].key"
    value = "CriticalAddonsOnly"
  }
  set {
    name  = "msgTopologyOperator.tolerations[0].operator"
    value = "Exists"
  }
  set {
    name  = "msgTopologyOperator.tolerations[0].effect"
    value = "NoExecute"
  }
}
