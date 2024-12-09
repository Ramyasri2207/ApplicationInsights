output "instance_public_ip" {
  value = aws_instance.windows_sql.public_ip
}

output "application_insights_id" {
  value = aws_applicationinsights_application.app_insights.id
}
