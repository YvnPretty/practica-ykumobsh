# Práctica: Backups Automáticos de MariaDB

Este repositorio contiene los scripts y la documentación para la implementación de un sistema de respaldos automáticos para MariaDB en Linux.

## Contenido del Repositorio

- `backup_scripts/scripts/backup.sh`: Versión básica del script de respaldo (exportación y compresión).
- `backup_scripts/scripts/backup_avanzado.sh`: Versión avanzada que incluye:
  - Validación de conexión.
  - Cifrado con OpenSSL.
  - Manejo de errores estricto.
  - Registro de logs detallado.
  - Soporte para envío remoto via `scp`.
- `backup_scripts/scripts/.env.example`: Plantilla para configurar las credenciales de base de datos y parámetros de seguridad.

## Instrucciones de Uso

1. Copiar el archivo de ejemplo a uno real:
   ```bash
   cp backup_scripts/scripts/.env.example .env
   ```
2. Editar `.env` con tus credenciales.
3. Dar permisos de ejecución:
   ```bash
   chmod +x backup_scripts/scripts/backup_avanzado.sh
   ```
4. Ejecutar el script:
   ```bash
   ./backup_scripts/scripts/backup_avanzado.sh
   ```

## Automatización

Para ejecutar el respaldo diariamente a las 2 AM, añade la siguiente línea a tu crontab (`crontab -e`):

```cron
0 2 * * * /home/yvnsu/backup_scripts/scripts/backup_avanzado.sh
```
