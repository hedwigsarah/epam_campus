output "load_balancer_ip" {
  description = "The external IP address of the LoadBalancer service"
  value       = try(data.kubernetes_service_v1.app.status[0].load_balancer[0].ingress[0].ip, "")
}

output "service_name" {
  description = "The name of the Kubernetes service"
  value       = data.kubernetes_service_v1.app.metadata[0].name
}