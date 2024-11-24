resource "kubernetes_manifest" "rabbitmq_cluster" {
  manifest = {
    apiVersion = "rabbitmq.com/v1beta1"
    kind       = "RabbitmqCluster"
    metadata = {
      name      = "rabbitmq-cluster"
      namespace = "rabbitmq"
    }
    spec = {
      replicas = 3
      resources = {
        requests = {
          cpu    = "100m"
          memory = "256Mi"
        }
        limits = {
          cpu    = "500m"
          memory = "512Mi"
        }
      }
      service = {
        type = "ClusterIP"
      }
      persistence = {
        storageClassName = "longhorn"
        storage          = "1Gi"
      }
      tolerations = [
        {
          key      = "CriticalAddonsOnly"
          operator = "Equal"
          effect   = "NoExecute"
          value    = "true"
        }
      ]
      affinity = {
        nodeAffinity = {
          requiredDuringSchedulingIgnoredDuringExecution = {
            nodeSelectorTerms = [
              {
                matchExpressions = [
                  {
                    key      = "role"
                    operator = "In"
                    values   = ["server"]
                  }
                ]
              }
            ]
          }
        }
      }
    }
  }
}

resource "kubernetes_manifest" "rabbitmq_vhost" {
  manifest = {
    apiVersion = "rabbitmq.com/v1beta1"
    kind       = "Vhost"
    metadata = {
      name      = "rabbitmq-vhost"
      namespace = "rabbitmq"
    }
    spec = {
      name = "fph"
      rabbitmqClusterReference = {
        name = "rabbitmq-cluster"
      }
    }
  }
}