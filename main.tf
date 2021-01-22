resource "kubernetes_namespace" "cicd" {
  metadata {
        name = "cicd"
  }
}

resource helm_release argocd {
    name        = "argo"
    repository  = "https://argoproj.github.io/argo-helm"
    chart       = "argo-cd"
    version     = "2.11.2"
    namespace   = "kube-system"

    values = [file("${path.module}/cd-values.yaml"),]
}

provider "kubernetes" {
  config_context_cluster   = "minikube"
  config_path              = "~/.kube/config"
}

provider "helm" {
  kubernetes {
        config_context_cluster   = "minikube"
        config_path              = "~/.kube/config"  
  }
}