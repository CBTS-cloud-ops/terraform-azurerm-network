# This block specifies the required providers and the required versions
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.36.0"
    }
  }
}

# Read resource group data for location
data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

# Create the virtual network supplied from var.network_info
resource "azurerm_virtual_network" "vnet" {
  name                = var.network_info.name
  resource_group_name = var.resource_group_name
  location            = data.azurerm_resource_group.resource_group.location
  address_space       = var.network_info.address_space
  dns_servers         = var.network_info.dns_servers
  tags = var.tags
}

# Create subnets for the virtual network supplied by var.network_info
resource "azurerm_subnet" "snet" {
  for_each                                  = var.network_info.subnets
  name                                      = each.value.name
  resource_group_name                       = var.resource_group_name
  virtual_network_name                      = azurerm_virtual_network.vnet.name
  address_prefixes                          = each.value.address_prefixes
  service_endpoints                         = each.value.service_endpoints

  dynamic "delegation" {
    for_each = lookup(local.service_delegation_map, each.value.service, [])

    content {
      name = "${each.value.service}-del-${each.value.name}"

      service_delegation {
        name    = delegation.value.servicename
        actions = delegation.value.actions
      }
    }
  }
}

# Create a NSG for each subnet if set_nsg is true
resource "azurerm_network_security_group" "nsg" {
  for_each            = { for s in compact([for s, v in var.network_info.subnets: v.set_nsg ? s : ""]): s => var.network_info.subnets[s] }
  name                = "nsg-${each.value.name}"
  resource_group_name = var.resource_group_name
  location            = data.azurerm_resource_group.resource_group.location
  tags                = merge({ "Resource" = "nsg-${each.value.name}"}, var.tags,)

  dynamic "security_rule" {
    for_each = concat(lookup(each.value, "nsg_inbound_rules",), lookup(each.value, "nsg_outbound_rules", []))

    content {
      name                       = security_rule.value[0] == "" ? "Default_Rule" : security_rule.value[0]
      priority                   = security_rule.value[1]
      direction                  = security_rule.value[2] == "" ? "Inbound" : security_rule.value[2]
      access                     = security_rule.value[3] == "" ? "Allow" : security_rule.value[3]
      protocol                   = security_rule.value[4] == "" ? "Tcp" : security_rule.value[4]
      source_port_range          = "*"
      destination_port_range     = security_rule.value[5] == "" ? "*" : security_rule.value[5]
      source_address_prefix      = security_rule.value[6] == "" ? element(each.value.address_prefix, 0) : security_rule.value[6]
      destination_address_prefix = security_rule.value[7] == "" ? element(each.value.address_prefix, 0) : security_rule.value[7]
      description                = "${security_rule.value[2]}_Port_${security_rule.value[5]}"
    }
  }
}

# Associate NSG to subnet if set_nsg is true
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each                  = { for s in compact([for s, v in var.network_info.subnets: v.set_nsg ? s : ""]): s => var.network_info.subnets[s] }
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
  subnet_id                 = azurerm_subnet.snet[each.key].id
}

# If not a hub vnet create the network peering from hub vnet to spoke vnet
resource "azurerm_virtual_network_peering" "hub2spoke" {
  count                        = var.hubvnet_name == "" ? 0 : 1
  name                         = "peer-${var.hubvnet_name}-TO-${azurerm_virtual_network.vnet.name}"
  resource_group_name          = var.hubvnet_rg == "" ? data.azurerm_resource_group.resource_group.name : var.hubvnet_rg
  virtual_network_name         = var.hubvnet_name
  remote_virtual_network_id    = azurerm_virtual_network.vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = false
}

# If not a hub vnet create the network peering from spoke vnet to hub vnet
resource "azurerm_virtual_network_peering" "spoke2hub" {
  count                        = var.hubvnet_name == "" ? 0 : 1
  name                         = "peer-${azurerm_virtual_network.vnet.name}-TO-${var.hubvnet_name}"
  resource_group_name          = data.azurerm_resource_group.resource_group.name
  virtual_network_name         = azurerm_virtual_network.vnet.name
  remote_virtual_network_id    = var.hubvnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = var.network_info.use_remote_gateways
}