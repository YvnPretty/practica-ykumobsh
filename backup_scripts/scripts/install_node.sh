#!/bin/bash
# Script para instalar NVM y Node.js

echo "Instalando NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Instalando Node.js (LTS)..."
nvm install --lts

echo "Verificando instalación:"
node -v
npm -v
