terraform {
    backend "kubernetes" {
        secret_suffix = "state"
        # namespace = "default"
        # config_path = "~/.kube/config"
        load_config_file = "false" # Can we detect the cluster from ARC?
    }

    required_providers {
      helm = {
      source = "hashicorp/helm"
      version = "2.16.1"
    }
    }
}
