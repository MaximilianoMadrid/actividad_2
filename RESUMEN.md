# 📋 RESUMEN - Servicio OAuth2 con Consumo de API REST

## ✅ Lo que se ha implementado

### 1. **Servicio con Autenticación OAuth2 y JWT**
   - Endpoint de login: `POST /api/auth/login`
   - Generación de tokens JWT con RS256
   - Duración: 1 hora
   - Usuarios en memoria: user/password

### 2. **Endpoint Protegido**
   - Ruta: `GET /api/data/hola`
   - Protegido por token JWT
   - Solo accesible si estás autenticado
   - Devuelve JSON con "Hola Mundo"

### 3. **Consumo de API REST**
   - Usa API externa: JSONPlaceholder (https://jsonplaceholder.typicode.com)
   - RestTemplate configurado para consumir APIs
   - Información del usuario incluida en la respuesta

---

## 🎯 Flujo Completo

```
┌─ HACER LOGIN ────────────────────┐
│ POST /api/auth/login             │
│ {username: "user",               │
│  password: "password"}           │
│ ↓                                │
│ Respuesta: {token: "JWT_TOKEN"}  │
└─┬──────────────────────────────────┘
  │
  └─ USAR ENDPOINT PROTEGIDO ──────┐
    │ GET /api/data/hola           │
    │ Header: Authorization: Bearer TOKEN
    │ ↓                             │
    │ Respuesta: {                │
    │   "mensaje": "Hola Mundo",   │
    │   "usuario": "user",         │
    │   "timestamp": "...",        │
    │   "apiExterna": "JSONPlaceholder",
    │   "estado": "autenticado"   │
    │ }                            │
    └─────────────────────────────┘
```

---

## 🔧 Archivos Nuevos/Modificados

### Nuevos:
- ✨ `DataController.java` - Endpoint /api/data/hola
- ✨ `ApiService.java` - Servicio para consumir APIs

### Modificados:
- 📝 `SecurityConfig.java` - Agregado bean RestTemplate
- 📝 `application.properties` - Configuración del servidor

---

## 🚀 Cómo Ejecutar

**Opción 1 - Terminal directo:**
```bash
cd /workspaces/actividad_2/demoOAUTH2-master
mvn spring-boot:run
```

**Opción 2 - Usar script:**
```bash
cd /workspaces/actividad_2
bash run-service.sh
```

El servidor estará disponible en: **http://localhost:8080**

---

## 🧪 Probar la API

**Terminal 1 - Ejecutar servicio:**
```bash
cd /workspaces/actividad_2/demoOAUTH2-master
mvn spring-boot:run
```

**Terminal 2 - Probar endpoints:**

### Paso 1: Login
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"user","password":"password"}'
```

### Paso 2: Copiar el token y usarlo
```bash
TOKEN="eyJhbGciOiJSUzI1NiIs..." # Copiar del paso anterior

curl -X GET http://localhost:8080/api/data/hola \
  -H "Authorization: Bearer $TOKEN"
```

### Resultado Esperado:
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

## 📁 Estructura de Archivos

```
/workspaces/actividad_2/
├── README.md              ← Documentación completa
├── EJEMPLOS.md           ← Ejemplos con curl
├── ESTRUCTURA.md         ← Estructura del proyecto
├── INICIO.sh             ← Guía rápida
├── RESUMEN.md            ← Este archivo
├── run-service.sh        ← Script para ejecutar
├── test-api.sh           ← Script para probar
│
└── demoOAUTH2-master/
    ├── pom.xml
    ├── src/main/java/com/example/demoAuth/
    │   ├── DemoAuthApplication.java
    │   ├── auth/AuthController.java
    │   ├── controller/DataController.java        ✨ NUEVO
    │   ├── service/ApiService.java              ✨ NUEVO
    │   └── security/SecurityConfig.java         📝 MODIFICADO
    └── src/main/resources/application.properties  📝 MODIFICADO
```

---

## 🔐 Seguridad

✅ Autenticación con JWT (JSON Web Token)  
✅ Algoritmo RSA 256 bits  
✅ Tokens válidos por 1 hora  
✅ Endpoints protegidos requieren token válido  
✅ Sin token = Error 401 Unauthorized  

---

## 📚 Tecnologías Utilizadas

- **Spring Boot** 4.0.5
- **Spring Security** - Autenticación
- **OAuth2** - Authorization Server & Resource Server
- **JWT** - Tokens seguros
- **RestTemplate** - Consumo de APIs
- **Maven** - Gestor de dependencias
- **Java** 21

---

## 💡 Ejemplo Completo en Postman

1. **Crear request POST:**
   - URL: `http://localhost:8080/api/auth/login`
   - Body (JSON): `{"username":"user","password":"password"}`
   - Send → Copiar token

2. **Crear request GET:**
   - URL: `http://localhost:8080/api/data/hola`
   - Headers → Auth → Bearer Token → Pegar token
   - Send → Ver "Hola Mundo" en JSON

---

## ❓ Preguntas Frecuentes

**P: ¿Por qué me da 401?**  
R: Necesitas incluir el token válido en el header `Authorization: Bearer {token}`

**P: ¿Puedo cambiar el usuario/contraseña?**  
R: Actualiza `SecurityConfig.java` en la sección `userDetailsService()`

**P: ¿Puedo consumir otra API?**  
R: Modifica la URL en `ApiService.java` línea 21

**P: ¿Cuánto dura el token?**  
R: 3600 segundos (1 hora). Modifica en `AuthController.java` línea 30

---

## 🎓 Conceptos Implementados

- **OAuth2**: Framework de autorización
- **JWT**: Token seguro sin estado en el servidor
- **RS256**: Encriptación asimétrica (pública/privada)
- **RestTemplate**: Cliente HTTP para consumir APIs
- **Spring Security**: Seguridad a nivel de aplicación
- **Inyección de Dependencias**: Patrón de diseño usado por Spring

---

## 📞 Próximos Pasos

Si quieres mejorar el servicio:

1. Agregar Base de Datos
2. Implementar Refresh Token
3. Agregar más roles y permisos
4. Validar entrada de usuarios
5. Agregar Rate Limiting
6. Implementar logging avanzado

---

✅ **TODO LISTO PARA EJECUTAR**

Ejecuta: `mvn spring-boot:run` y accede a `http://localhost:8080`
