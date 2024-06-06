module "naming" {
  source = "../naming"

  for_each = var.resource_map

  base_name     = each.key
  resource_type = each.value
}
