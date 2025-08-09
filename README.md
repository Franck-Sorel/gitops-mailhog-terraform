# GitOps MailHog with Terraform and Argo CD

This repository demonstrates how to set up and manage a MailHog instance on Kubernetes using a GitOps workflow. Terraform is used for the initial setup of the infrastructure, and Argo CD manages the application deployment.

## Architecture

The architecture of this project is composed of the following components:

- **Terraform**: Used to provision the necessary Kubernetes resources to bootstrap the environment. This includes:
  - Creating the `argocd` and `mailhog` namespaces.
  - Installing Argo CD using the official Helm chart.

- **Argo CD**: A declarative, GitOps continuous delivery tool for Kubernetes.
  - Once installed, Argo CD monitors the Git repository for changes in the application's desired state.
  - It automatically syncs the application state in the Kubernetes cluster to match the state defined in the Git repository.
  - This project contains two Argo CD `Application` resources: `mailhog-app.yaml` for the dev environment and `mailhog-prod-app.yaml` for the prod environment.

- **Kustomize**: Used to customize Kubernetes resource configuration for different environments.
  - The `manifests` directory contains the Kubernetes manifests for MailHog.
  - The `base` directory holds the common resources (`deployment.yaml`, `service.yaml`).
  - The `overlays` directory contains environment-specific configurations (`dev`, `prod`).

- **MailHog**: An email testing tool with a web UI and API. It's deployed as a Kubernetes Deployment and exposed as a ClusterIP Service.

## Getting Started

### Prerequisites

- `kubectl` connected to a Kubernetes cluster.
- `terraform` CLI installed.

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/franck-sorel/gitops-mailhog-terraform.git
   cd gitops-mailhog-terraform
   ```

2. **Initialize and apply Terraform:**

   This will set up the namespaces and install Argo CD.

   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

3. **Deploy the MailHog application using Argo CD:**

   Apply the Argo CD application manifest to your cluster. This will instruct Argo CD to start managing the MailHog deployment.

   For the **dev** environment:
   ```bash
   kubectl apply -f ../argocd-apps/mailhog-app.yaml
   ```

   For the **prod** environment:
   ```bash
   kubectl apply -f ../argocd-apps/mailhog-prod-app.yaml
   ```

   Argo CD will then automatically sync the resources defined in the `manifests/overlays/dev` or `manifests/overlays/prod` directory.

## Usage

To access the MailHog Web UI, you can use `kubectl port-forward` to forward a local port to the MailHog service.

1. **Find the MailHog service:**

   ```bash
   kubectl get svc -n mailhog
   ```

2. **Port-forward the service:**

   The MailHog UI runs on port `8025`.

   ```bash
   kubectl port-forward svc/mailhog 8025:8025 -n mailhog
   ```

3. **Open your browser:**

   Navigate to `http://localhost:8025` to view the MailHog UI.
