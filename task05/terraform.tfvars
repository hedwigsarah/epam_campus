resource_groups = {
  rg1 = {
    name     = "cmaz-7ymyr7zc-mod5-rg-01"
    location = "East US"
  }
  rg2 = {
    name     = "cmaz-7ymyr7zc-mod5-rg-02"
    location = "West Europe"
  }
  rg3 = {
    name     = "cmaz-7ymyr7zc-mod5-rg-03"
    location = "UK South"
  }
}

app_service_plans = {
  asp1 = {
    name               = "cmaz-7ymyr7zc-mod5-asp-01"
    resource_group_key = "rg1"
    sku_name           = "S1"
    worker_count       = 2
  }
  asp2 = {
    name               = "cmaz-7ymyr7zc-mod5-asp-02"
    resource_group_key = "rg2"
    sku_name           = "S1"
    worker_count       = 1
  }
}

app_services = {
  app1 = {
    name                 = "cmaz-7ymyr7zc-mod5-app-01"
    resource_group_key   = "rg1"
    app_service_plan_key = "asp1"
  }
  app2 = {
    name                 = "cmaz-7ymyr7zc-mod5-app-02"
    resource_group_key   = "rg2"
    app_service_plan_key = "asp2"
  }
}

traffic_manager_name               = "cmaz-7ymyr7zc-mod5-traf"
traffic_manager_resource_group_key = "rg3"
traffic_manager_routing_method     = "Performance"

tags = {
  Creator = "sarah-hedwig_popescu@epam.com"
}

allowed_ip   = "18.153.146.156"
ip_rule_name = "allow-ip"
tm_rule_name = "allow-tm"