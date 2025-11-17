variable "name" {
  type        = string
  description = "Name of gitlab-runner"
}

variable "ns_labels" {
  type        = map(string)
  description = "Map with labels for k8s namespace"
  default = {}
}

variable "custom_helm_values" {
  type        = string
  default     = ""
  description = "Custom YAML helm values"
}

variable "tolerations" {
  description = <<EOF
    Node tolerations for server scheduling to nodes with taints
    Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
    Example value:
      - key: app
        operator: Equal
        value: infra
        effect: NoSchedule
  EOF
  type        = string
  default     = ""
}

variable "affinity" {
  description = <<EOF
    Affinity and anti-affinity rules for server scheduling to nodes
    Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity
    Example value:
      nodeAffinity:
        preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            preference:
              matchExpressions:
              - key: "app"
                operator: "In"
                values:
                - "infra"
  EOF
  type        = string
  default     = ""
}

variable "gitlab_url" {
  type        = string
  description = "URL gitlab server"
}

variable "gitlab_token" {
  type        = string
  description = "runner token for access"
}

variable "gitlab_runner_concurrent" {
  type        = number
  default     = 5
  description = "concurrent job parallel"
}

variable "gitlab_runner_image" {
  type        = object({
    registry = string
    image    = string
    tag      = string
  })
  default = {
    registry = "registry.gitlab.com"
    image    = "gitlab-org/gitlab-runner"
    tag      = "alpine-v{{.Chart.AppVersion}}"
  }
  description = "image gitlab runner"
}

variable "runner_config" {
  type = object({
    cpu_lim = optional(string, "500m")
    cpu_req = optional(string, "200m")
    mem_lim= optional(string, "1Gi")
    mem_req= optional(string, "512Mi")
    image  = optional(string, "28.5.2-alpine3.22")
    help_cpu_lim= optional(string, "100m")
    help_cpu_req= optional(string, "100m")
    help_mem_lim= optional(string, "128Mi")
    help_mem_req= optional(string, "128Mi")
    help_image  = optional(string, "registry.gitlab.com/gitlab-org/gitlab-runner/gitlab-runner-helper:alpine3.21-x86_64-v{{.Chart.AppVersion}}")
  })
  description = "params for runners.kubernetes"
}

variable "rbac_rules" {
  type        = string
  default = <<EOF
rules:
  - apiGroups: ["*"]
    resources: ["pods","pods/attach","pods/exec","serviceaccounts","services","namespaces"]
    verbs: ["get", "create", "apply", "update", "patch", "delete", "list", "watch"]
  - apiGroups: ["*"]
    resources: ["configmaps", "secrets"]
    verbs: ["get","create", "apply", "update", "patch", "delete", "list"]
  - apiGroups: ["apps"]
    resources: ["daemonsets","deployments","replicasets","statefulsets"]
    verbs: ["get", "create", "apply", "update", "patch", "delete", "list", "watch"]
  - apiGroups: ["batch"]
    resources: ["cronjobs","jobs","ingresses"]
    verbs: ["get", "create", "apply", "update", "patch", "delete", "list", "watch"]
  - apiGroups: ["networking.k8s.io","extensions"]
    resources: ["ingresses"]
    verbs: ["get", "create", "apply", "update", "patch", "delete", "list", "watch"]
  - apiGroups: ["rbac.authorization.k8s.io"]
    resources: ["rolebindings","roles"]
    verbs: ["get", "create", "apply", "update", "patch", "delete", "list", "watch"]
  - apiGroups: ["*"]
    resources: ["persistentvolumeclaims","persistentvolumes","volumeattachments"]
    verbs: ["get", "create", "apply", "update", "patch", "delete", "list", "watch"]
  - apiGroups: ["operator.victoriametrics.com"]
    resources: ["vmservicescrapes","vmstaticscrapes","vmpodscrapes","vmnodescrapes","vmrules"]
    verbs: ["get", "create", "apply", "update", "patch", "delete", "list", "watch"]
EOF
  description = "access for sa gitlab-runner"
}