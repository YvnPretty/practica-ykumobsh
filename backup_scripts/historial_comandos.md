# Reporte de Actividad en Terminal
**Fecha:** 29 de Abril, 2026

## Resumen de Acciones

| Comando | Estado | Descripción |
| :--- | :--- | :--- |
| `apt install -y ufw` | **Fallido** | Error de permisos (lock-frontend). |
| `mkdir proyectos scripts backups` | **Completado** | Creación de estructura de base. |
| `nvm install node` | **Pendiente*** | Script generado en `scripts/install_node.sh`. |
| `verificar lamp` | **Pendiente*** | Script generado en `scripts/verificar_lamp.sh`. |

## Detalle de Comandos

```bash
$ sudo apt update
$ apt install -y ufw
E: No se pudo abrir el fichero de bloqueo «/var/lib/dpkg/lock-frontend» - open (13: Permiso denegado)
```

```bash
$ mkdir -p proyectos scripts backups
$ ls -la /home/yvnsu/backup_scripts
```

> [!NOTE]
> *Nota: Debido a restricciones en el entorno de ejecución, se han proporcionado scripts automatizados para que el usuario los ejecute directamente.*
