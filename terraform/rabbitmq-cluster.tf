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
          memory = "1Gi"
        }
        limits = {
          cpu    = "500m"
          memory = "2Gi"
        }
      }
      service = {
        type = "ClusterIP"
      }
      persistence = {
        storageClassName = "longhorn"
        storage          = "5Gi"
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

resource "kubernetes_manifest" "rabbitmq_queue" {
  manifest = {
    apiVersion = "rabbitmq.com/v1beta1"
    kind       = "Queue"
    metadata = {
      name      = "rabbitmq-queue"
      namespace = "rabbitmq"
    }
    spec = {
      name    = "proba-feladat"
      vhost   = "fph"
      durable = true
      rabbitmqClusterReference = {
        name = "rabbitmq-cluster"
      }
      autoDelete = false
    }
  }
}