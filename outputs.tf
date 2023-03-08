output "vnet_name" {
  description = "Outputs the name of the vnet that is created."
  value = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Outputs the ID of the vnet that is created."
  value = azurerm_virtual_network.vnet.id
}

# This output is useful to identify the order of the Subnets to derive their index ID of the subnets
# when used in conjuction with creating other resources attached to specific subnets
output "subnet_ids" {
  description = "Outputs the IDs of the subnets that are created"
  value = [for snet in azurerm_subnet.snet : snet.id]
}

output "gw_subnet_id" {
  description = "Outputs the ID of the Gateway Subnet in a hub vnet if created"
  value = {for gw in azurerm_subnet.snet : id => gw.id if gw.name == "GatewaySubnet"}
}