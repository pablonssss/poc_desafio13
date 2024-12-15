terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1"
    }
  }
}

provider "null" {}

resource "null_resource" "dummy" {
  provisioner "local-exec" {
    command = "echo Terraform ejecutado correctamente"
  }
}
