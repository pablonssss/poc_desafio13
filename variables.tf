# Definir variables para la configuración de Terraform

# Región de AWS
variable "aws_region" {
  description = "La región de AWS donde se implementará la infraestructura"
  type        = string
  default     = "us-east-1"
}

# Tipo de instancia
variable "instance_type" {
  description = "Instancia EC2"
  type        = string
  default     = "t2.micro"
}

# Tamaño del volumen EBS
variable "volumen_size" {
  description = "Tamaño del volumen EBS"
  type        = number
  default     = 10
}

# Nombre del recurso
variable "instance_name" {
  description = "Nombre Instancia EC2"
  type        = string
  default     = "Ejemplo_Desafio12"
}

# TAGS para recursos
variable "tags" {
  description = "Tags para todos los recursos"
  type        = map(string)
  default = {
    Owner           = "Pablo Navarrete"
    Email           = "pnavarrete1985@gmail.com"
    Team            = "DevOpsTeam"
    Proyectogrupo-1 = "Desafio 12"
  }
}
