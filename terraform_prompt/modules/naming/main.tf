locals {
  truncated_base_name = var.base_name

  formatted_name = (var.resource_type == "virtual_machine" ? format("vm-%s-00", substr(local.truncated_base_name, 0, 9)) :
                   var.resource_type == "key_vault" ? lower(format("kv-%s", var.base_name)) :
                   var.resource_type == "storage_account" ? lower(replace(format("sa%s", var.base_name), "-", "")) :
                   var.base_name
  )

  latest_base_name = substr(local.formatted_name, 0, 15)
}


resource "aws_instance" exampleInstance {
  count         = var.resource_type == "virtual_machine" ? 1 : 0
  ami           = "ami-0ca2e925753ca2fb4"  # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"

  tags = {
    Name = local.latest_base_name
  }
}

resource "aws_s3_bucket" "exampleBucket" {
  count  = var.resource_type == "storage_account" ? 1 : 0
  bucket = local.latest_base_name

  tags = {
    Name = local.latest_base_name
  }
 }

resource "aws_kms_key" "example" {
  count  = var.resource_type == "key_vault" ? 1 : 0
  description = var.key_description

  tags = {
    Environment = "Prod"
    Owner       = local.latest_base_name
  }
 }

  resource "aws_kms_alias" "example" {
    count  = var.resource_type == "key_vault" ? 1 : 0

    name          = "alias/${local.latest_base_name}"
    target_key_id = aws_kms_key.example[count.index].key_id
  }


  # output of entered resource name 
  
  output "resource_name" {
    value = local.latest_base_name
  }