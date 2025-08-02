variable "argocd_namespace" {
  description = "Namespace for Argo CD installation"
  type        = string
  default     = "argocd"
}

variable "argocd_chart_version" {
  description = "Version of the Argo CD Helm chart"
  type        = string
  default     = "5.51.6"
}

variable "mailhog_namespace" {
  description = "Namespace for Mailhog application"
  type        = string
  default     = "mailhog"
}
