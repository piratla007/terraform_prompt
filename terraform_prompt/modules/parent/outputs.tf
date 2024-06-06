#Outputs from the child module:

output "latest_base_name" {
  description = "A map of base names to formatted resource names"
  value       = { for name, mod in module.naming : name => mod.latest_base_name }
}