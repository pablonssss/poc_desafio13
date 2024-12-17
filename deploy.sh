#!/bin/bash

# El script falle ante cualquier error
set -e

# Variables de entorno
REPO_DIR=/Users/pablonssss/poc_desafio13
BRANCH="main"

echo "Deploy completo del proyecto..."

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


# Configuración de Git y Terraform
echo "Asegurando repositorio Git..."
cd "$REPO_DIR"

# Verifica cambios en el repositorio
if [[ $(git status --porcelain) ]]; then
    echo "Cambios detectados. Subiendo a GitHub..."
    git add .
    git commit -m "Despliegue automatizado con Docker, GitHub Actions y Terraform Cloud"
    git push origin $BRANCH
else
    echo "No hay cambios por subir a GitHub."
fi

echo "Despliegue completado correctamente. Revisa la creacion del recurso"
