output "sonarqube" {
  description = "Sonarqube Credentials "
  value = {
    username = "admin",
    password = nonsensitive(random_password.sonarqube_password.result),
    url      = var.sonarqube_config.hostname
  }
}

output "sonarqube_postgresql_password" {
  value       = random_password.postgresql_password.result
  description = "Password for the PostgreSQL database deployed with SonarQube"
  sensitive   = true
}

output "sonarqube_postgresql_username" {
  value       = "sonarUser"
  description = "Username for the PostgreSQL database deployed with SonarQube"
}
