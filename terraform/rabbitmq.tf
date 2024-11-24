resource "helm_release" "rabbitmq_operator" {
    name       = "rabbitmq-operator"
    repository = "https://charts.bitnami.com/bitnami"
    chart      = "rabbitmq-cluster-operator"
    version    = "4.3.27"

    set {
        name  = "tolerations[0].key"
        value = "CriticalAddonsOnly"
    }

    set {
        name  = "tolerations[0].operator"
        value = "Equal"
    }

    set {
        name  = "tolerations[0].value"
        value = "true"
    }

    set {
        name  = "tolerations[0].effect"
        value = "NoExecute"
    }
}