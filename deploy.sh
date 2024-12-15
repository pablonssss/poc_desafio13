#!/bin/bash

# El script falle ante cualquier error
set -e

# Variables de entorno
REPO_DIR=/Users/pablonssss/poc_desafio13
BRANCH="main"

echo "Deploy completo del proyecto..."

# Verifica que Docker esté instalado
if ! command -v docker &> /dev/null; then
    echo "Docker no está instalado"
    exit 1
fi

# Verifica que Docker Compose este instalado
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose no está instalado"
    exit 1
fi

# Verifica que Git esté instalado
if ! command -v git &> /dev/null; then
    echo "Git no está instalado"
    exit 1
fi

# Verifica que Terraform esté instalado
if ! command -v terraform &> /dev/null; then
    echo "Terraform no está instalado"
    exit 1
fi

# Despliegue con Docker Compose
echo "Iniciando contenedores con Docker Compose..."
docker-compose down   # Elimina contenedores anteriores, por las dudas
docker-compose up --build -d

# Verifica que los contenedores estén activos
echo "Verificando contenedores activos..."
docker-compose ps

# 2. Configuración de Git y Terraform
echo "Asegurando repositorio Git..."
cd $REPO_DIR

# Verifica cambios en el repositorio
if [[ $(git status --porcelain) ]]; then
    echo "Cambios detectados. Subiendo a GitHub..."
    git add .
    git commit -m "Despliegue automatizado con Docker, GitHub Actions y Terraform Cloud"
    git push origin $BRANCH
else
    echo "No hay cambios por subir a GitHub."
fi

# 3. Ejecutar Terraform Cloud
echo "Ejecutando Terraform Plan y Apply desde Terraform Cloud..."

# Inicia Terraform
terraform init -input=false

# Ejecuta Terraform Plan y Apply
terraform plan -out=tfplan -input=false \
  -var "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
  -var "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"

terraform apply -input=false -auto-approve tfplan

# Mensaje Final
echo "Despliegue completado correctamente. Revisa tu aplicación en http://localhost"
