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
    namespace   = "cicd"

    values = [file("${path.module}/cd-values.yaml"),]
}

resource helm_release argo-workflow {
    name        = "argo-ci"
    repository  = "https://argoproj.github.io/argo-helm"
    chart       = "argo"
    version     = "0.15.2"
    namespace   = "cicd"

    values = [file("${path.module}/workflow-values.yaml"),]
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