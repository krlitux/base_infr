module "web_app_dev" {
  source = "./resources"

  azure_app_name        = "WEBAPPDEMO"
  azure_app_location    = "EUS"
  azure_app_environment = "D"
  azure_app_budget      = 1000
  tags = {
    project        = "DemoProject"
    appName        = "WEBAPPDEMO"
    pointOfContact = "iops.carlitos@gmail.com"
    deploymentDate = "15/01/2024"
  }
}

module "web_app_dev01" {
  source = "./resources"

  azure_app_name        = "WEBAPPDEMO"
  azure_app_location    = "WUS"
  azure_app_environment = "D"
  azure_app_budget      = 1000
  tags = {
    project        = "DemoProject"
    appName        = "WEBAPPDEMO"
    pointOfContact = "iops.carlitos@gmail.com"
    deploymentDate = "23/08/2024"
  }
}

module "web_app_qa" {
  source = "./resources"

  azure_app_name        = "WEBAPPDEMO"
  azure_app_location    = "EUS"
  azure_app_environment = "Q"
  azure_app_budget      = 1000
  tags = {
    project        = "DemoProject"
    appName        = "WEBAPPDEMO"
    pointOfContact = "iops.carlitos@gmail.com"
    deploymentDate = "15/01/2024"
  }
}
