terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.4.0"
}

# Declarar las variables
variable "AWS_ACCESS_KEY_ID" {
  description = "Clave de acceso de AWS"
  type        = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "Clave secreta de AWS"
  type        = string
}

# Configurar el proveedor de AWS usando las variables
provider "aws" {
  region                  = "us-east-1"
  access_key              = var.AWS_ACCESS_KEY_ID
  secret_access_key       = var.AWS_SECRET_ACCESS_KEY
}

provider "null" {}

resource "null_resource" "dummy" {
  provisioner "local-exec" {
    command = "echo Terraform ejecutado correctamente"
  }
}
