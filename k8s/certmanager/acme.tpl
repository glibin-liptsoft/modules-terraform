resources:
  - apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: "${name}"
    spec:
      acme:
        email: "${email}"
        server: "${server}"

        privateKeySecretRef:
          name: "${tls_key}"
%{ if key_id != "" }
        externalAccountBinding:
          keyID: "${key_id}"
          keySecretRef:
            name: "${key_secret}"
            key: secret
%{ endif }
        solvers:
        - dns01:
            webhook:
              config:
                # The ID of the folder where dns-zone located in
                folder: "${folder_id}"
                # This is the secret used to access the service account
                serviceAccountSecretRef:
                  name: "${serviceAccount}"
                  key: iamkey.json
              groupName: acme.cloud.yandex.com
              solverName: yandex-cloud-dns