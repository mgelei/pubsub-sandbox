resource "kubernetes_manifest" "rabbitmq-user" {
  manifest = {
    apiVersion = "rabbitmq.com/v1beta1"
    kind       = "User"
    metadata = {
      name      = "rabbitmq-user-admin"
      namespace = "rabbitmq"
    }
    spec = {
      tags = ["management", "policymaker", "administrator", "monitoring"]
      rabbitmqClusterReference = {
        name = "rabbitmq-cluster"
      }
      importCredentialsSecret = {
        name = "rabbitmq-user-secret"
      }
    }
  }
}

resource "kubernetes_manifest" "rabbitmq-permission" {
  manifest = {
    apiVersion = "rabbitmq.com/v1beta1"
    kind       = "Permission"
    metadata = {
      name      = "rabbitmq-permission-admin"
      namespace = "rabbitmq"
    }
    spec = {
      vhost = "fph"
      user  = "rabbitmq-user-admin"
      permissions = {
        configure = "proba-feladat.*"
        write     = "proba-feladat.*"
        read      = "proba-feladat.*"
      }
      rabbitmqClusterReference = {
        name = "rabbitmq-cluster"
      }
    }
  }

}