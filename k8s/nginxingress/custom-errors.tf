locals {
  error404_template = file("${path.module}/404.html")
  error500_template = file("${path.module}/500.html")
}

resource "helm_release" "custom_errors" {
  count = var.default_backend_override ? 1 : 0

  name       = "${var.name}-errors"
  repository = "https://helm-charts.wikimedia.org/stable"
  chart      = "raw"
  version    = "0.3.0"
  namespace  = var.name

  depends_on = [
    kubernetes_namespace.this
  ]

  values = [
    <<YAML
resources:
- apiVersion: v1
  kind: ConfigMap
  metadata:
    name: custom-error-pages
    namespace: ${var.name}
  data:
    404: |-
      ${indent(6, local.error404_template)}
    502: |-
      ${indent(6, local.error500_template)}
    503: |-
      ${indent(6, local.error500_template)}
    504: |-
      ${indent(6, local.error500_template)}
- apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: ${var.ingressClass}-errors
    namespace: ${var.name}
    labels:
      app.kubernetes.io/name: ${var.ingressClass}-errors
      app.kubernetes.io/part-of: ${var.ingressClass}
  spec:
    replicas: 1
    selector:
      matchLabels:
        app.kubernetes.io/name: ${var.ingressClass}-errors
        app.kubernetes.io/part-of: ${var.ingressClass}
    template:
      metadata:
        labels:
          app.kubernetes.io/name: ${var.ingressClass}-errors
          app.kubernetes.io/part-of: ${var.ingressClass}
      spec:
        containers:
        - name: nginx-error-server
          image: registry.k8s.io/ingress-nginx/nginx-errors:1.3.0
          resources:
            requests:
              cpu: 100m
              memory: 50Mi
          ports:
          - containerPort: 8080
          volumeMounts:
          - name: custom-error-pages
            mountPath: "/www"
        volumes:
        - name: custom-error-pages
          configMap:
            name: custom-error-pages
            items:
            - key: "404"
              path: 404.html
            - key: "502"
              path: 502.html
            - key: "503"
              path: 503.html
            - key: "504"
              path: 504.html
      %{~if length(var.affinity) > 0}
        affinity:
          ${indent(10, var.affinity)}
      %{~endif}
      %{~if length(var.tolerations) > 0}
        tolerations:
          ${indent(10, var.tolerations)}
      %{~endif}
- apiVersion: v1
  kind: Service
  metadata:
    name: ${var.ingressClass}-errors
    namespace: ${var.name}
    labels:
      app.kubernetes.io/name: ${var.ingressClass}-errors
      app.kubernetes.io/part-of: ${var.ingressClass}
  spec:
    selector:
      app.kubernetes.io/name: ${var.ingressClass}-errors
      app.kubernetes.io/part-of: ${var.ingressClass}
    ports:
    - port: 80
      targetPort: 8080
      name: http
    YAML
  ]
}
