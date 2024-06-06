
variable "resource_type" {
  description = "Type of the resource"
  type        = string
  validation {
    # Set the condition variables
    condition     = contains(["virtual_machine", "key_vault", "storage_account"], var.resource_type)

    # Set the error message for any incorrect value
    error_message = "resource_type must be one of 'virtual_machine', 'key_vault', or 'storage_account'."
  }
}

variable "base_name" {
  description = "Base name for the resource"
  type        = string
#  validation {
#    condition     = length(var.base_name) <= 15 
#    error_message = "The max length of base_name should be 15" 
#  }
}

