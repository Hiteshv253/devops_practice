############################
# Terraform Settings Block #
############################

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.16"
    }
  }
  required_version = ">= 1.0.0"
}

#########################
# Kubernetes Provider   #
#########################

provider "kubernetes" {
  # Use the kubeconfig for authentication
  config_path = "~/.kube/config"
}

#########################
# Namespace (Optional)  #
#########################

resource "kubernetes_namespace" "example" {
  metadata {
    name = "webapp-namespace"
  }
}

##################################
# Kubernetes Deployment Resource #
##################################

resource "kubernetes_deployment" "frontend" {
  metadata {
    name      = "frontend"
    namespace = kubernetes_namespace.example.metadata[0].name
  }

  spec {
    replicas = 4

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name  = "frontend-container"
          image = "nginx:1.21.6"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}

##############################
# Kubernetes Service Resource #
##############################

resource "kubernetes_service" "webapp_service" {
  metadata {
    name      = "webapp-service"
    namespace = kubernetes_namespace.example.metadata[0].name
  }

  spec {
    selector = {
      app = "frontend"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
