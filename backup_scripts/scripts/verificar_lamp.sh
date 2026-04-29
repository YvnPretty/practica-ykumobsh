#!/bin/bash
# Script para verificar el estado de LAMP

echo "--- Verificando LAMP ---"

echo "Apache2:"
if command -v apache2 >/dev/null; then
    apache2 -v
else
    echo "Apache2 no está instalado."
fi

echo -e "\nMySQL:"
if command -v mysql >/dev/null; then
    mysql --version
else
    echo "MySQL no está instalado."
fi

echo -e "\nPHP:"
if command -v php >/dev/null; then
    php -v
else
    echo "PHP no está instalado."
fi
