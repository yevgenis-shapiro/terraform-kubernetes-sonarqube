## Sonarqube Static Code Analisys

![1690265830089](https://github.com/user-attachments/assets/f6c48dc9-345c-48ff-9c06-09b01e223f69)

<br>
Sonarqube is an open-source tool that provides continuous code quality management to perform automatic reviews with static analysis of code to detect bugs, code smells, and security vulnerabilities. This module uses Kubernetes manifests to deploy Sonarqube along with a PostgreSQL database. It allows for easy configuration of the Sonarqube instance through the use of Terraform variables.

## Supported Versions:

|  Sonarqube Helm Chart Version           |     K8s supported version (EKS, AKS & GKE)  |  
| :-----:                       |         :---         |
| **1.0.30**          |    **1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30**      |


## Usage Example

```hcl
module "sonarqube" {
    source           = "squareops/sonarqube/kubernetes"
    version          = "3.0.1"
  sonarqube_config = {
    hostname                       = "sonarqube.squareops.in"
    values_yaml                    = file("./helm/values.yaml")
    storage_class_name             = "gp2"
    sonarqube_volume_size          = "5Gi"
    postgresql_volume_size         = "20Gi"
    grafana_monitoring_enabled     = false
    postgresql_password_external   = ""
    postgresql_external_server_url = ""
  }
}
```
- Refer [AWS examples](https://github.com/yevgenis-shapiro/terraform-kubernetes-sonarqube/tree/main/examples/complete/aws) for more details.
- Refer [Azure examples](https://github.com/yevgenis-shapiro/terraform-kubernetes-sonarqube/tree/main/examples/complete/azure) for more details.
- Refer [GCP examples](https://github.com/yevgenis-shapiro/terraform-kubernetes-sonarqube/tree/main/examples/complete/gcp) for more details.


## Important Notes
  ✅ In order to enable the exporter, it is required to deploy Prometheus/Grafana first.
  ✅ The exporter is a tool that extracts metrics data from an application or system and makes it available to be scraped by Prometheus.
  ✅ Prometheus is a monitoring system that collects metrics data from various sources, including exporters, and stores it in a time-series database.
  ✅ Grafana is a data visualization and dashboard tool that works with Prometheus and other data sources to display the collected metrics in a user-friendly way.
  ✅ To deploy Prometheus/Grafana, please follow the installation instructions for each tool in their respective documentation.
  ✅ Once Prometheus and Grafana are deployed, the exporter can be configured to scrape metrics data from your application or system and send it to Prometheus.
  ✅ Finally, you can use Grafana to create custom dashboards and visualize the metrics data collected by Prometheus.
  ✅ This module is compatible with EKS, AKS & GKE which is great news for users deploying the module on an AWS, Azure & GCP cloud. Review the module's documentation, meet specific configuration requirements, and test thoroughly after deployment to ensure everything works as expected.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.sonarqube](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.sonarqube](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [random_password.postgresql_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.sonarqube_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of the Jenkins chart that will be used to deploy Jenkins application. | `string` | `"10.6.1"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Name of the Kubernetes namespace where the Jenkins deployment will be deployed. | `string` | `"sonarqube"` | no |
| <a name="input_sonarqube_config"></a> [sonarqube\_config](#input\_sonarqube\_config) | Specify the configuration settings for Sonarqube, including the hostname, storage options, and custom YAML values. | `any` | <pre>{<br>  "grafana_monitoring_enabled": false,<br>  "hostname": "",<br>  "postgresql_external_server_url": "",<br>  "postgresql_password_external": "",<br>  "postgresql_volume_size": "",<br>  "sonarqube_volume_size": "",<br>  "storage_class_name": "",<br>  "values_yaml": ""<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sonarqube"></a> [sonarqube](#output\_sonarqube) | Sonarqube Credentials |
| <a name="output_sonarqube_postgresql_password"></a> [sonarqube\_postgresql\_password](#output\_sonarqube\_postgresql\_password) | Password for the PostgreSQL database deployed with SonarQube |
| <a name="output_sonarqube_postgresql_username"></a> [sonarqube\_postgresql\_username](#output\_sonarqube\_postgresql\_username) | Username for the PostgreSQL database deployed with SonarQube |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

