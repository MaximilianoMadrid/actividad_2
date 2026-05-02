#!/bin/bash
# RUNBOOK - Guía paso a paso

cat << 'EOF'
╔════════════════════════════════════════════════════════════════╗
║                                                                ║
║     RUNBOOK: SERVICIO OAUTH2 + API REST + HOLA MUNDO          ║
║                                                                ║
║     Todos los requisitos implementados y funcionales           ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝

▶ PASO 1: PREPARAR EL PROYECTO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Ubicación: /workspaces/actividad_2/demoOAUTH2-master

✓ Ya está configurado con:
  • Spring Boot 4.0.5
  • Spring Security OAuth2
  • JWT con RS256
  • RestTemplate para APIs
  • DataController con endpoint protegido
  • ApiService que consume JSONPlaceholder


▶ PASO 2: EJECUTAR EL SERVICIO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Opción A - Maven (recomendado):
└─ cd /workspaces/actividad_2/demoOAUTH2-master
   mvn spring-boot:run

Opción B - Script:
└─ cd /workspaces/actividad_2
   bash run-service.sh

Espera hasta ver: "Started DemoAuthApplication in X seconds"

El servidor estará en: http://localhost:8080


▶ PASO 3: USAR EL SERVICIO (ABRIR OTRA TERMINAL)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PASO 3A: LOGIN y obtener Token
────────────────────────────────

Comando:
$ curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"user","password":"password"}'

Respuesta esperada:
{
  "username": "user",
  "roles": ["ROLE_USER"],
  "token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
  "message": "Login correcto"
}

⚠️  IMPORTANTE: Copia el valor de "token"


PASO 3B: Acceder al endpoint "Hola Mundo" (protegido)
──────────────────────────────────────────────────────

Reemplaza {TOKEN} con el token del paso anterior:

$ TOKEN="eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9..."

$ curl -H "Authorization: Bearer $TOKEN" \
  http://localhost:8080/api/data/hola

Respuesta esperada:
{
  "mensaje": "Hola Mundo",
  "timestamp": "2026-05-02T10:30:45.123Z",
  "apiExterna": "JSONPlaceholder",
  "estado": "autenticado",
  "usuario": "user"
}

✅ ¡ÉXITO! Ya tienes el servicio funcionando


▶ PASO 4: VERIFICACIONES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Verificación 1: ¿Funciona sin autenticación?
────────────────────────────────────────────

$ curl http://localhost:8080/api/data/hola

Resultado esperado: 401 Unauthorized
{
  "error": "No autenticado"
}

✓ Correcto, está protegido


Verificación 2: ¿Devuelve "Hola Mundo"?
───────────────────────────────────────

$ curl -H "Authorization: Bearer $TOKEN" \
  http://localhost:8080/api/data/hola | grep "mensaje"

Resultado esperado: "mensaje":"Hola Mundo"

✓ Correcto


Verificación 3: ¿Consume API externa?
──────────────────────────────────────

$ curl -H "Authorization: Bearer $TOKEN" \
  http://localhost:8080/api/data/hola | grep "apiExterna"

Resultado esperado: "apiExterna":"JSONPlaceholder"

✓ Correcto


▶ PASO 5: USAR CON POSTMAN
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Si prefieres una interfaz gráfica:

1. Abre Postman
2. Nueva Request → POST
   URL: http://localhost:8080/api/auth/login
   Body → JSON:
   {
     "username": "user",
     "password": "password"
   }
   Send → Copia el token

3. Nueva Request → GET
   URL: http://localhost:8080/api/data/hola
   Auth → Type: Bearer Token
   Token: {pegar token aquí}
   Send → Verás "Hola Mundo" en JSON


▶ ARCHIVOS IMPORTANTES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📄 README.md           - Documentación completa
📄 EJEMPLOS.md         - Ejemplos adicionales
📄 ESTRUCTURA.md       - Estructura del proyecto
📄 CHECKLIST.md        - Verificación de requisitos
📄 RESUMEN.md          - Resumen ejecutivo

🔧 Código:
  • DataController.java - GET /api/data/hola
  • ApiService.java     - Consume JSONPlaceholder
  • SecurityConfig.java - Configuración OAuth2 + JWT


▶ ENDPOINTS DISPONIBLES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

POST /api/auth/login
└─ Login y obtener token JWT
   Requiere: {"username":"user", "password":"password"}
   Devuelve: {token, roles, username, message}

GET /api/auth/me
└─ Información del usuario autenticado
   Requiere: Token JWT válido
   Devuelve: {username, roles, message}

GET /api/data/hola  ⭐ PROTEGIDO
└─ "Hola Mundo" consumiendo API externa
   Requiere: Token JWT válido
   Devuelve: {"mensaje":"Hola Mundo", usuario, timestamp, apiExterna, estado}


▶ SOLUCIÓN DE PROBLEMAS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Problema: "Connection refused"
Solución: El servicio no está corriendo
         - Verifica que mvn spring-boot:run esté ejecutándose
         - Verifica que sea en puerto 8080

Problema: 401 Unauthorized
Solución: Token inválido o no enviado
         - Verifica que el token esté en el header Authorization
         - Verifica que sea: "Bearer {token}"
         - Obtén un nuevo token con login

Problema: Token inválido/expirado
Solución: El token dura 1 hora
         - Haz login nuevamente para obtener uno nuevo

Problema: Error al consumir API externa
Solución: Verifica tu conexión a internet
         - La API JSONPlaceholder debe estar accesible


▶ COMANDOS RÁPIDOS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Login
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"user","password":"password"}' | jq '.'

# Guardar token en variable
TOKEN=$(curl -s -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"user","password":"password"}' | jq -r '.token')

# Usar el token
curl -H "Authorization: Bearer $TOKEN" \
  http://localhost:8080/api/data/hola | jq '.'

# Ver desplegado bonito con jq
curl -H "Authorization: Bearer $TOKEN" \
  http://localhost:8080/api/data/hola | jq '.' 


▶ ¿ESTÁ TODO CORRECTO?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Servicio levantado en puerto 8080?
✅ Autenticación OAuth2 con JWT?
✅ Endpoint protegido /api/data/hola?
✅ Devuelve "Hola Mundo" en JSON?
✅ Consumo de API REST (JSONPlaceholder)?
✅ Solo accesible si está autenticado?

Todo implementado y funcional.

EOF
