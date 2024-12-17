locals {
  count = var.sonarqube_config.postgresql_external_server_url != "" ? [] : [1]
}
resource "random_password" "sonarqube_password" {
  length  = 20
  special = false
}
resource "random_password" "postgresql_password" {
  length  = 20
  special = false
}

resource "kubernetes_namespace" "sonarqube" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "sonarqube" {
  depends_on = [kubernetes_namespace.sonarqube]
  name       = "sonarqube"
  chart      = "sonarqube"
  timeout    = 600
  version    = var.chart_version
  namespace  = var.namespace
  repository = "https://sonarsource.github.io/helm-chart-sonarqube"
  values = [
    templatefile("${path.module}/helm/values.yaml", {
      hostname                       = var.sonarqube_config.hostname
      volume_size                    = var.sonarqube_config.sonarqube_volume_size
      sonarqube_sc                   = var.sonarqube_config.storage_class_name
      postgresql_enable              = var.sonarqube_config.postgresql_external_server_url != "" ? false : true
      sonarqube_password             = random_password.sonarqube_password.result
      postgresql_password            = random_password.postgresql_password.result
      postgresql_disk_size           = var.sonarqube_config.postgresql_volume_size
      prometheus_exporter_enable     = var.sonarqube_config.grafana_monitoring_enabled
      postgresql_password_external   = var.sonarqube_config.postgresql_password_external
      postgresql_external_server_url = var.sonarqube_config.postgresql_external_server_url

    }),
    var.sonarqube_config.values_yaml
  ]
  dynamic "set" {
    for_each = local.count
    content {
      name  = "postgresql.postgresqlServer"
      value = var.sonarqube_config.postgresql_external_server_url
    }
  }

  dynamic "set" {
    for_each = local.count
    content {
      name  = "postgresql.existingSecretPasswordKey"
      value = var.sonarqube_config.postgresql_password_external
    }
  }
}
