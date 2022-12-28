locals {
  service_delegation_map = {
    serverfarm = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/action", ]
        servicename = "Microsoft.Web/serverFarms"
      }
    }
    containergroups = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/action", ]
        servicename = "Microsoft.ContainerInstance/containerGroups"
      }
    }
    fabricmesh = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/action", ]
        servicename = "Microsoft.ServiceFabricMesh/networks"
      }
    }
    integrationservices = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/action", ]
        servicename = "Microsoft.Logic/integrationServiceEnvironments"
      }
    }
    batchaccounts = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/action", ]
        servicename = "Microsoft.Batch/batchAccounts"
      }
    }
    managedinstances = {
      default = {
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action", ]
        servicename = "Microsoft.Sql/managedInstances"
      }
    }
    hosting = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/action", ]
        servicename = "Microsoft.Web/hostingEnvironments"
      }
    }
    databricks = {
      default = {
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action", ]
        servicename = "Microsoft.Databricks/workspaces"
      }
    }
    streaminganalytics = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action", ]
        servicename = "Microsoft.StreamAnalytics/streamingJobs"
      }
    }
    postgresql = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.DBforPostgreSQL/serversv2"
      }
    }
    cosmosdb = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.AzureCosmosDB/clusters"
      }
    }
    machinelearning = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.MachineLearningServices/workspaces"
      }
    }
    postgresql-server = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.DBforPostgreSQL/singleServers"
      }
    }
    postgresql-flex = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.DBforPostgreSQL/flexibleServers"
      }
    }
    mysql = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.DBforMySQL/serversv2"
      }
    }
    mysql-flex = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.DBforMySQL/flexibleServers"
      }
    }
    apimanagement = {
      default = {
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
        servicename = "Microsoft.ApiManagement/service"
      }
    }
    synapse = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.Synapse/workspaces"
      }
    }
    powerplatform-vnet = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.PowerPlatform/vnetaccesslinks"
      }
    }
    dnsresolvers = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.Network/dnsResolvers"
      }
    }
    network-controller = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.DelegatedNetwork/controller"
      }
    }
    containers-clusters = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.ContainerService/managedClusters"
      }
    }
    powerplatform-policies = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.PowerPlatform/enterprisePolicies"
      }
    }
    diskpools = {
      default = {
        actions     = []
        servicename = "Microsoft.StoragePool/diskPools"
      }
    }
    cassandra = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.DocumentDB/cassandraClusters"
      }
    }
    devcenter-network = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "Microsoft.DevCenter/networkConnection"
      }
    }
    nginx = {
      default = {
        actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        servicename = "NGINX.NGINXPLUS/nginxDeployments"
      }
    }
  }
}