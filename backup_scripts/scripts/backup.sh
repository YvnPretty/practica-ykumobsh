#!/bin/bash
# Script de respaldo automático para MariaDB - Versión Mejorada
# Basado en la práctica guiada

# Variables de configuración (Se recomienda usar el script avanzado con .env)
# Si usas este script, edita estas variables manualmente:
DB_USER="PON_AQUI_TU_USUARIO"
DB_PASSWORD="PON_AQUI_TU_PASSWORD"
DB_NAME="PON_AQUI_TU_BASE_DE_DATOS"
BACKUP_DIR="$HOME/backups"
LOG_FILE="$HOME/backup.log"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Crear carpeta de respaldo si no existe
mkdir -p "$BACKUP_DIR"

# Redirigir toda la salida al log
exec > >(tee -a "$LOG_FILE") 2>&1

echo "-------------------------------------------"
echo "Fecha: $(date)"
echo "Iniciando respaldo de la base de datos: $DB_NAME..."

# Crear respaldo usando mysqldump
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_DIR/$DB_NAME-$DATE.sql"

# Verificar si el respaldo fue exitoso
if [ $? -eq 0 ]; then
    echo "Respaldo exportado correctamente."
    
    # Comprimir respaldo
    gzip "$BACKUP_DIR/$DB_NAME-$DATE.sql"
    echo "Respaldo comprimido: $DB_NAME-$DATE.sql.gz"
    
    # Eliminar respaldos antiguos (más de 7 días)
    echo "Limpiando respaldos antiguos..."
    find "$BACKUP_DIR" -type f -name "*.gz" -mtime +7 -exec rm -v {} \;
    
    echo "Respaldo completado exitosamente."
else
    echo "Error: Falló el respaldo de la base de datos."
    exit 1
fi
echo "-------------------------------------------"
