output "argocd_namespace" {
  description = "Namespace where Argo CD is installed"
  value       = kubernetes_namespace.argocd.metadata[0].name
}

output "mailhog_namespace" {
  description = "Namespace where Mailhog will be deployed"
  value       = kubernetes_namespace.mailhog.metadata[0].name
}

output "argocd_server_service" {
  description = "Argo CD server service name"
  value       = "argocd-server"
}

output "get_admin_password_command" {
  description = "Command to get Argo CD admin password"
  value       = "kubectl get secret argocd-initial-admin-secret -n ${var.argocd_namespace} -o jsonpath=\"{.data.password}\" | base64 --decode"
}

output "port_forward_command" {
  description = "Command to port-forward Argo CD server"
  value       = "kubectl port-forward svc/argocd-server -n ${var.argocd_namespace} 8080:443"
}
