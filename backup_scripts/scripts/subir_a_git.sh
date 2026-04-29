#!/bin/bash
# Script para subir los cambios a Git usando el Token proporcionado

# No guardar tokens aquí por seguridad (GitHub Push Protection)
TOKEN="${GIT_TOKEN}"
REPO_URL="https://$TOKEN@github.com/YvnPretty/practica-ykumobsh.git"

echo "Configurando repositorio..."
# Intentar configurar el remoto si no existe o actualizarlo
git remote set-url origin "$REPO_URL" 2>/dev/null || git remote add origin "$REPO_URL"

echo "Limpiando el área de preparación..."
git reset

echo "Añadiendo solo lo necesario (scripts y reportes)..."
git add scripts/ log.txt historial_comandos.md historial_comandos.pdf 2>/dev/null

echo "Creando commit limpio..."
git commit -m "Solo scripts y reportes de actividad"

echo "Sincronizando con cambios remotos..."
# Guardar cambios temporales para permitir el pull/rebase
git stash

BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")
git pull --rebase origin "$BRANCH"

# Recuperar cambios si es necesario
git stash pop 2>/dev/null

echo "Subiendo a la rama principal ($BRANCH)..."
git push origin "$BRANCH"

echo "¡Proceso de Git completado!"
