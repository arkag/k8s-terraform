locals {
  grafana_manifests = provider::kubernetes::manifest_decode_multi(file("apps/grafana.yml"))
  grafana_manifests_metadata = [for i in range(length(local.grafana_manifests)) : merge(
    local.grafana_manifests[i].metadata, {
      "namespace" = kubernetes_namespace.grafana.metadata[0].name
    }
    )
  ]
  grafana_manifests_w_namespace = [for i in range(length(local.grafana_manifests)) : merge(
    local.grafana_manifests[i], {
      metadata = local.grafana_manifests_metadata[i]
    }
    )
  ]
}

resource "kubernetes_namespace" "grafana" {
  metadata {
    name = "grafana"
  }
}

resource "kubernetes_manifest" "grafana" {
  count    = length(local.grafana_manifests)
  manifest = local.grafana_manifests_w_namespace[count.index]
}
