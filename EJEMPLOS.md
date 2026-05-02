# Ejemplos de uso del Servicio OAuth2

## Resumen rápido

El servicio incluye:
- ✅ Autenticación JWT
- ✅ Endpoint protegido `/api/data/hola`
- ✅ Consumo de API REST externa
- ✅ Respuesta JSON con "Hola Mundo"

---

## Ejemplos con curl

### 1. Login y obtener token JWT

```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "user",
    "password": "password"
  }'
```

**Respuesta exitosa (200)**:
```json
{
  "username": "user",
  "roles": ["ROLE_USER"],
  "token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
  "message": "Login correcto"
}
```

---

### 2. Acceder al endpoint protegido (requiere token)

**Paso 1**: Guarda el token de la respuesta anterior en una variable:
```bash
TOKEN="eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9..."
```

**Paso 2**: Usa el token para acceder al endpoint:
```bash
curl -X GET http://localhost:8080/api/data/hola \
  -H "Authorization: Bearer $TOKEN"
```

**Respuesta exitosa (200)**:
```json
{
  "mensaje": "Hola Mundo",
  "timestamp": "2026-05-02T10:30:45.123Z",
  "apiExterna": "JSONPlaceholder",
  "estado": "autenticado",
  "usuario": "user"
}
```

---

### 3. Acceso sin token (fallará con 401)

```bash
curl -X GET http://localhost:8080/api/data/hola
```

**Respuesta (401 Unauthorized)**:
```json
{
  "error": "No autenticado"
}
```

---

### 4. Verificar información del usuario autenticado

```bash
curl -X GET http://localhost:8080/api/auth/me \
  -H "Authorization: Bearer $TOKEN"
```

**Respuesta (200)**:
```json
{
  "username": "user",
  "roles": ["ROLE_USER"],
  "token": null,
  "message": "Usuario autenticado"
}
```

---

## Usando Postman

1. **Crear petición POST** para login
   - URL: `http://localhost:8080/api/auth/login`
   - Body (JSON): 
     ```json
     {
       "username": "user",
       "password": "password"
     }
     ```
   - Enviar y copiar el valor del campo `token`

2. **Crear petición GET** para obtener "Hola Mundo"
   - URL: `http://localhost:8080/api/data/hola`
   - Headers:
     - Key: `Authorization`
     - Value: `Bearer {TOKEN_COPIADO_AQUI}`
   - Enviar y ver la respuesta JSON

---

## Estructura de la aplicación

```
src/main/java/com/example/demoAuth/
├── DemoAuthApplication.java          # Aplicación principal
├── auth/
│   └── AuthController.java           # Endpoints de login
├── controller/
│   └── DataController.java           # Endpoint protegido /api/data/hola
├── service/
│   └── ApiService.java               # Servicio para consumir API
└── security/
    └── SecurityConfig.java           # Configuración OAuth2 y JWT
```

---

## Flujo de autenticación

```
1. Usuario envía credenciales → POST /api/auth/login
   ↓
2. Servidor verifica credenciales
   ↓
3. Servidor genera JWT token
   ↓
4. Usuario recibe token
   ↓
5. Usuario incluye token en header: Authorization: Bearer {token}
   ↓
6. Usuario accede a → GET /api/data/hola
   ↓
7. Servidor valida token
   ↓
8. Si es válido: Devuelve "Hola Mundo" + consume API externa
   Si es inválido: Devuelve 401 Unauthorized
```

---

## Notas técnicas

- **Algoritmo JWT**: RS256 (RSA)
- **Tiempo de expiración**: 3600 segundos (1 hora)
- **User Details Service**: En memoria (user/password)
- **API externa consumida**: JSONPlaceholder
- **Puerto**: 8080
