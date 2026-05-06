#!/bin/bash
# Script de respaldo automático MariaDB - Versión Avanzada
# Implementa: .env, validación, cifrado, scp y manejo de errores

# 1. Manejo de errores estricto
set -e
set -o pipefail

# 2. Cargar variables desde .env
ENV_FILE="$(dirname "$0")/.env"
if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' "$ENV_FILE" | xargs)
else
    echo "Error: Archivo .env no encontrado en $ENV_FILE"
    exit 1
fi

DATE=$(date +%Y-%m-%d_%H-%M-%S)
mkdir -p "$BACKUP_DIR"

# 3. Configuración de Logs con fecha
exec > >(tee -a "$LOG_FILE") 2>&1

echo "==========================================="
echo "INICIO DE RESPALDO AVANZADO: $(date)"

# 4. Validación de conexión a la base de datos
echo "Validando conexión a MariaDB..."
if ! mysqladmin -u "$DB_USER" -p"$DB_PASSWORD" ping >/dev/null 2>&1; then
    echo "Error: No se puede conectar a MariaDB. Verifique credenciales."
    exit 1
fi
echo "Conexión exitosa."

# 5. Crear respaldo
FILE_BASE="$BACKUP_DIR/$DB_NAME-$DATE"
echo "Exportando base de datos: $DB_NAME..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$FILE_BASE.sql"

# 6. Comprimir
echo "Comprimiendo archivo..."
gzip "$FILE_BASE.sql"

# 7. Cifrado (Versión Avanzada)
echo "Cifrando respaldo..."
openssl enc -aes-256-cbc -salt -in "$FILE_BASE.sql.gz" -out "$FILE_BASE.sql.gz.enc" -pass pass:"$ENCRYPTION_PASS" -pbkdf2
rm "$FILE_BASE.sql.gz" # Eliminar el archivo comprimido sin cifrar

# 8. Envío remoto (Opcional - requiere llaves SSH configuradas)
if [ ! -z "$REMOTE_HOST" ] && [ "$REMOTE_HOST" != "ip_o_host_remoto" ]; then
    echo "Enviando a servidor remoto: $REMOTE_HOST..."
    if scp -o BatchMode=yes "$FILE_BASE.sql.gz.enc" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"; then
        echo "Envío remoto completado."
    else
        echo "Advertencia: Falló el envío remoto (verifique llaves SSH)."
    fi
fi

# 9. Limpieza (más de 7 días)
echo "Limpiando archivos antiguos..."
find "$BACKUP_DIR" -type f -name "*.enc" -mtime +7 -exec rm -v {} \;

echo "PROCESO FINALIZADO EXITOSAMENTE"
echo "==========================================="
