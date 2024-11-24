resource "helm_release" "rabbitmq_operator" {
  name       = "rabbitmq-operator"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "rabbitmq-cluster-operator"
  version    = "4.3.27"
  namespace  = "rabbitmq"

  values = [<<EOF
clusterOperator:
  tolerations:
    - key: "CriticalAddonsOnly"
      operator: "Equal"
      effect: "NoExecute"
      value: "true"
  nodeSelector:
    role: server
msgTopologyOperator:
  tolerations:
    - key: "CriticalAddonsOnly"
      operator: "Equal"
      effect: "NoExecute"
      value: "true"
  nodeSelector:
    role: "server"
EOF
]
}
