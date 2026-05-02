#!/bin/bash

# Script para probar los endpoints del servicio OAuth2

BASE_URL="http://localhost:8080"
CREDENTIALS='{
  "username": "user",
  "password": "password"
}'

echo "========================================="
echo "Cliente de Prueba - Servicio OAuth2"
echo "========================================="
echo ""

# 1. Login
echo "1️⃣  Realizando login..."
echo "   POST $BASE_URL/api/auth/login"
echo "   Credenciales: user/password"
echo ""

RESPONSE=$(curl -s -X POST "$BASE_URL/api/auth/login" \
  -H "Content-Type: application/json" \
  -d "$CREDENTIALS")

echo "Respuesta:"
echo "$RESPONSE" | jq '.'
echo ""

# Extraer token
TOKEN=$(echo "$RESPONSE" | jq -r '.token')

if [ -z "$TOKEN" ] || [ "$TOKEN" == "null" ]; then
    echo "❌ Error: No se pudo obtener el token"
    exit 1
fi

echo "✓ Token obtenido correctamente"
echo ""

# 2. Obtener información del usuario autenticado
echo "2️⃣  Obteniendo información del usuario..."
echo "   GET $BASE_URL/api/auth/me"
echo ""

curl -s -X GET "$BASE_URL/api/auth/me" \
  -H "Authorization: Bearer $TOKEN" | jq '.'

echo ""
echo ""

# 3. Obtener "Hola Mundo" (endpoint protegido)
echo "3️⃣  Obteniendo 'Hola Mundo' (endpoint protegido)..."
echo "   GET $BASE_URL/api/data/hola"
echo ""

curl -s -X GET "$BASE_URL/api/data/hola" \
  -H "Authorization: Bearer $TOKEN" | jq '.'

echo ""
echo ""

# 4. Intentar acceder sin token (fallará)
echo "4️⃣  Intentando acceder sin token (debe fallar)..."
echo "   GET $BASE_URL/api/data/hola (sin Authorization)"
echo ""

curl -s -X GET "$BASE_URL/api/data/hola" | jq '.'

echo ""
echo ""
echo "========================================="
echo "✓ Pruebas completadas"
echo "========================================="
