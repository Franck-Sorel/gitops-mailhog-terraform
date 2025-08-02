# Create Argo CD namespace
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }
}

# Create Mailhog namespace
resource "kubernetes_namespace" "mailhog" {
  metadata {
    name = var.mailhog_namespace
  }
}

