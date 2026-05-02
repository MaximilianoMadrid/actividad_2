# Estructura Final del Proyecto

```
/workspaces/actividad_2/
│
├── README.md                                    # Documentación principal
├── EJEMPLOS.md                                  # Ejemplos de uso con curl
├── run-service.sh                               # Script para ejecutar el servicio
├── test-api.sh                                  # Script para probar la API
│
└── demoOAUTH2-master/                          # Proyecto Spring Boot
    ├── pom.xml                                  # Configuración Maven
    ├── mvnw                                     # Maven Wrapper (Linux/Mac)
    ├── mvnw.cmd                                 # Maven Wrapper (Windows)
    │
    ├── src/
    │   ├── main/
    │   │   ├── java/com/example/demoAuth/
    │   │   │   ├── DemoAuthApplication.java     # App principal
    │   │   │   ├── auth/
    │   │   │   │   └── AuthController.java      # Endpoints: login, me
    │   │   │   ├── controller/                  # NUEVO
    │   │   │   │   └── DataController.java      # NUEVO - Endpoint protegido
    │   │   │   ├── service/                     # NUEVO
    │   │   │   │   └── ApiService.java          # NUEVO - Servicio de API
    │   │   │   └── security/
    │   │   │       └── SecurityConfig.java      # Config OAuth2 + JWT + RestTemplate
    │   │   │
    │   │   └── resources/
    │   │       └── application.properties       # Config del servidor
    │   │
    │   └── test/
    │       └── java/com/example/demoAuth/
    │           └── DemoAuthApplicationTests.java
```

## Cambios Implementados

### 1. **Nuevos archivos Java**

#### `src/main/java/com/example/demoAuth/controller/DataController.java`
- Endpoint protegido por JWT
- `GET /api/data/hola` - Solo accesible con token válido
- Devuelve "Hola Mundo" en JSON con información del usuario

#### `src/main/java/com/example/demoAuth/service/ApiService.java`
- Servicio que consume API REST externa (JSONPlaceholder)
- Construye respuesta JSON con "Hola Mundo"
- Incluye timestamp y información de la API consumida

### 2. **Modificaciones**

#### `src/main/java/com/example/demoAuth/security/SecurityConfig.java`
- ✅ Agregado import de `RestTemplate`
- ✅ Agregado bean `RestTemplate` para consumir APIs

#### `src/main/resources/application.properties`
- ✅ Configuración de puerto (8080)
- ✅ Nivel de logging configurado
- ✅ OAuth2 resource server configurado

### 3. **Scripts de Utilidad**

- `run-service.sh` - Para ejecutar el servicio
- `test-api.sh` - Para probar todos los endpoints

---

## Dependencias del pom.xml

✅ `spring-boot-starter-security` - Autenticación y autorización  
✅ `spring-boot-starter-security-oauth2-authorization-server` - Servidor OAuth2  
✅ `spring-boot-starter-security-oauth2-resource-server` - Resource Server OAuth2  
✅ `spring-boot-starter-webmvc` - Spring MVC y RestTemplate  
✅ `spring-boot-devtools` - Herramientas de desarrollo  

---

## Flow de la Aplicación

```
┌─────────────────────────────────────────────────────────────┐
│                    CLIENTE (Navegador/Postman)              │
└─────────────────────────────────────────────────────────────┘
                           ↓↑
              POST /api/auth/login (credenciales)
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                     SERVIDOR SPRING                         │
│                                                             │
│  AuthController.login()                                    │
│  ├─ Verifica credenciales con UserDetailsService          │
│  ├─ Genera JWT token con RS256                            │
│  └─ Devuelve token al cliente                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                           ↓
         Cliente recibe token y lo guarda
                           ↓
┌─────────────────────────────────────────────────────────────┐
│           GET /api/data/hola + Authorization Bearer Token   │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                     SERVIDOR SPRING                         │
│                                                             │
│  SecurityFilterChain valida el token JWT                   │
│  ├─ Si inválido/expirado → 401 Unauthorized              │
│  └─ Si válido ↓                                           │
│                                                             │
│  DataController.getHolaMundo(Authentication)              │
│  ├─ ApiService.getHolaMundo()                             │
│  │  └─ RestTemplate consume JSONPlaceholder API           │
│  ├─ Agrega usuario autenticado a la respuesta            │
│  └─ Devuelve JSON con "Hola Mundo"                        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                           ↓
              Cliente recibe respuesta JSON
```

---

## Próximos Pasos (Opcional)

1. **Agregar autenticación de Base de Datos**
   - Reemplazar `InMemoryUserDetailsService` con una conectada a BD

2. **Consumir otras APIs**
   - Modificar `ApiService` para consumir diferentes APIs

3. **Agregar más roles y permisos**
   - Expandir la configuración de autorización en `SecurityConfig`

4. **Agregar RefreshToken**
   - Implementar endpoint para renovar tokens expirados
