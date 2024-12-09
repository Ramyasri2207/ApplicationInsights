resource "aws_resourcegroups_group" "my_resource_group" {
  name = "my-app-resource-group"

  resource_query {
    query = jsonencode({
      ResourceTypeFilters = ["AWS::EC2::Instance"]  # You can add other resource types as needed
      TagFilters = [
        {
          Key = "Name"
          Values = ["MyApplication"]
        }
      ]
    })
  }

  tags = {
    Name = "MyApplicationResourceGroup"
  }
}

# Create Application Insights for the resource group
resource "aws_applicationinsights_application" "app_insights" {
  resource_group_name = aws_resourcegroups_group.my_resource_group.name

  # CloudWatch metrics monitoring
  cwe_monitor_enabled = true

  # Enable integration with AWS OpsCenter
  ops_center_enabled = true

  tags = {
    Environment = "Production"
    Name        = "AppInsights-WindowsSQL"
  }
}
