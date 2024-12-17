output "sonarqube" {
  description = "Sonarqube_Info"
  value       = module.sonarqube.sonarqube
}

output "postgresql_password" {
  value       = module.sonarqube.sonarqube_postgresql_password
  description = "Password for the PostgreSQL database deployed with SonarQube"
  sensitive   = true
}

output "postgresql_username" {
  value       = "sonarUser"
  description = "Username for the PostgreSQL database deployed with SonarQube"
}
