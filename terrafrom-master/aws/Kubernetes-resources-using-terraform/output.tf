output "webapp_service_cluster_ip" {
  value = kubernetes_service.webapp_service.spec[0].cluster_ip
}