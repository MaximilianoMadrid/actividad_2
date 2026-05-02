#!/bin/bash

# Script para ejecutar el servicio de autenticación OAuth2

echo "========================================="
echo "Iniciando Servicio OAuth2 con JWT"
echo "========================================="
echo ""

cd demoOAUTH2-master

# Mostrar información del proyecto
echo "📦 Compilando y ejecutando el proyecto..."
echo ""

# Intentar usar Maven
if command -v mvn &> /dev/null; then
    echo "✓ Maven encontrado"
    mvn spring-boot:run
elif [ -f "./mvnw" ]; then
    echo "✓ Maven Wrapper encontrado"
    ./mvnw spring-boot:run
else
    echo "✗ Maven no encontrado. Instálalo primero con: apt-get install maven"
    exit 1
fi
