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



# Defino el Security_Group
resource "aws_security_group" "sec_group1" {
  name        = "web_security_group"
  description = "Permitir trafico HTTP, HTTPS y SSH"


  # Permitir tráfico entrante puerto 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Permitir trafico por el 443
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Permitir el trafico por el puerto 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permitir acceso SSH
  }

  # Permitir tráfico saliente
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Todo el tráfico saliente permitido
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Crear una instancia EC2 dentro de Free Tier
resource "aws_instance" "web" {
  ami           = "ami-0062355a529d6089c" # AmazonLinux2
  instance_type = var.instance_type

  # Asociar etiquetas comunes
  tags = merge(
    var.tags,
    {
      Name = "FreeTier_Desafio13" 
    }
  )

  vpc_security_group_ids = [aws_security_group.sec_group1.id]

}


