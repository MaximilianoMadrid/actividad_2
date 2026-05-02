# Servicio de Autenticación OAuth2 con Consumo de API REST

## Descripción
Este servicio Spring Boot implementa autenticación OAuth2 con JWT protegida. Incluye un endpoint que consume una API REST externa y devuelve "Hola Mundo" en formato JSON. El endpoint solo es accesible si el usuario está autenticado.

## Credenciales por defecto
- **Usuario**: `user`
- **Contraseña**: `password`

## Cómo ejecutar

### Opción 1: Usar Maven
```bash
cd demoOAUTH2-master
mvn spring-boot:run
```

### Opción 2: Usar el wrapper de Maven
```bash
cd demoOAUTH2-master
./mvnw spring-boot:run
```

El servicio se levantará en `http://localhost:8080`

## Endpoints disponibles

### 1. **Login (Obtener Token JWT)**
```bash
POST /api/auth/login
Content-Type: application/json

{
  "username": "user",
  "password": "password"
}
```

**Respuesta**:
```json
{
  "username": "user",
  "roles": ["ROLE_USER"],
  "token": "eyJhbGc...",
  "message": "Login correcto"
}
```

### 2. **Ver información del usuario autenticado**
```bash
GET /api/auth/me
Authorization: Bearer {token}
```

### 3. **Obtener "Hola Mundo" (Protegido por autenticación)**
```bash
GET /api/data/hola
Authorization: Bearer {token}
```

**Respuesta**:
```json
{
  "mensaje": "Hola Mundo",
  "timestamp": "2026-05-02T10:30:45.123Z",
  "apiExterna": "JSONPlaceholder",
  "estado": "autenticado",
  "usuario": "user"
}
```

## Flujo de uso

1. **Obtén el token JWT haciendo login**:
   ```bash
   curl -X POST http://localhost:8080/api/auth/login \
     -H "Content-Type: application/json" \
     -d '{"username":"user","password":"password"}'
   ```

2. **Usa el token para acceder al endpoint protegido**:
   ```bash
   curl -H "Authorization: Bearer TOKEN_JWT_AQUI" \
     http://localhost:8080/api/data/hola
   ```

## Características implementadas

✅ Autenticación OAuth2 con JWT  
✅ Endpoint protegido por token JWT  
✅ Consumo de API REST externa (JSONPlaceholder)  
✅ Respuesta en formato JSON con "Hola Mundo"  
✅ Solo accesible si está autenticado  
✅ Información del usuario en la respuesta  

## Tecnologías

- Spring Boot 4.0.5
- Spring Security OAuth2
- Spring OAuth2 Authorization Server
- Spring OAuth2 Resource Server
- JWT (JSON Web Token)
- Maven
- Java 21
