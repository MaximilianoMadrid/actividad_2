# 📚 ÍNDICE COMPLETO - Servicio OAuth2 con API REST

> **STATUS**: ✅ **COMPLETADO Y FUNCIONAL**
> 
> Todos los requisitos implementados y listos para ejecutar

---

## 🎯 INICIO RÁPIDO

**Si solo quieres ejecutar el servicio:**

```bash
# Terminal 1: Ejecutar servicio
cd /workspaces/actividad_2/demoOAUTH2-master
mvn spring-boot:run

# Terminal 2: Hacer login
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"user","password":"password"}'

# Terminal 2: Usar endpoint protegido (reemplaza TOKEN)
curl -H "Authorization: Bearer TOKEN" \
  http://localhost:8080/api/data/hola
```

👉 **Ver [RUNBOOK.md](RUNBOOK.md) para instrucciones detalladas paso a paso**

---

## 📖 DOCUMENTACIÓN

### Para Entender el Proyecto

| Archivo | Propósito | Lectura | Público |
|---------|-----------|---------|---------|
| [README.md](README.md) | 📋 Descripción general y cómo ejecutar | 5 min | Developers |
| [RESUMEN.md](RESUMEN.md) | 📊 Resumen ejecutivo del proyecto | 3 min | Managers/Revisores |
| [ESTRUCTURA.md](ESTRUCTURA.md) | 🏗️ Estructura de directorios y cambios | 10 min | Developers |
| [CHECKLIST.md](CHECKLIST.md) | ✅ Verificación de requisitos implementados | 5 min | QA/Testing |

### Para Usar el Proyecto

| Archivo | Propósito | Revisión |
|---------|-----------|----------|
| [RUNBOOK.md](RUNBOOK.md) | 🚀 Guía paso a paso (START HERE) | Lee primero |
| [EJEMPLOS.md](EJEMPLOS.md) | 💡 Ejemplos con curl y Postman | Consulta después |
| [ejemplos.json](ejemplos.json) | 📋 Especificación en JSON | Referencia técnica |

### Herramientas

| Archivo | Propósito |
|---------|-----------|
| [run-service.sh](run-service.sh) | 🔧 Script para ejecutar servicio |
| [test-api.sh](test-api.sh) | 🧪 Script para probar API |
| [INICIO.sh](INICIO.sh) | 📍 Guía visual rápida |

---

## 🏗️ CÓDIGO FUENTE

### Ubicación Base
```
/workspaces/actividad_2/demoOAUTH2-master/src/main/java/com/example/demoAuth/
```

### Archivos Nuevos (✨)

```
controller/
  └─ 📄 DataController.java
     • GET /api/data/hola (PROTEGIDO)
     • Devuelve "Hola Mundo" en JSON
     • Requiere token JWT válido

service/
  └─ 📄 ApiService.java
     • Consume JSONPlaceholder API
     • Construye respuesta JSON
     • Maneja excepciones
```

### Archivos Modificados (📝)

```
security/
  └─ SecurityConfig.java
     ✔ Agregado bean RestTemplate
     ✔ Importado RestTemplate

resources/
  └─ application.properties
     ✔ server.port=8080
     ✔ logging levels
     ✔ OAuth2 settings
```

### Archivos Existentes (no modificados)

```
auth/
  └─ AuthController.java (sin cambios)

DemoAuthApplication.java (sin cambios)
```

---

## 🔐 SEGURIDAD & AUTENTICACIÓN

### Método
- **Estándar**: OAuth2 + JWT
- **Algoritmo**: RS256 (RSA 2048 bits)
- **Duración Token**: 3600 segundos (1 hora)
- **Almacenamiento Usuarios**: En memoria

### Endpoints Protegidos
```
GET /api/data/hola ← Requiere JWT válido
```

### Endpoints Públicos
```
POST /api/auth/login
```

### Validación
```
1. Cliente incluye token en header:
   Authorization: Bearer {token}

2. SecurityFilterChain valida el JWT

3. Si válido → Acceso permitido
   Si inválido → 401 Unauthorized
```

---

## 📊 RESUMEN TÉCNICO

### Stack

| Componente | Tecnología | Versión |
|-----------|-----------|---------|
| Framework | Spring Boot | 4.0.5 |
| Seguridad | Spring Security | (incluida) |
| OAuth2 | Spring OAuth2 | (incluida) |
| JWT | Nimbus | (incluida) |
| Cliente HTTP | RestTemplate | (incluida en webmvc) |
| Lenguaje | Java | 21 |
| Build | Maven | (con wrapper) |

### Dependencias Principales
```
✓ spring-boot-starter-security
✓ spring-boot-starter-security-oauth2-authorization-server
✓ spring-boot-starter-security-oauth2-resource-server
✓ spring-boot-starter-webmvc (includes RestTemplate)
```

### API Externa Consumida
```
Nombre: JSONPlaceholder
URL: https://jsonplaceholder.typicode.com
Tipo: API REST gratuita
Datos: Fake posts, comments, users, etc.
```

---

## 🧪 PRUEBAS RECOMENDADAS

### Prueba 1: Autenticación
```bash
POST /api/auth/login
Credenciales: user/password
Espera: Token JWT válido
```

### Prueba 2: Endpoint Protegido SIN Token
```bash
GET /api/data/hola
Espera: 401 Unauthorized
```

### Prueba 3: Endpoint Protegido CON Token
```bash
GET /api/data/hola
Header: Authorization: Bearer {token}
Espera: {"mensaje":"Hola Mundo", ...}
```

### Prueba 4: Consumo de API
```bash
GET /api/data/hola
Valida: JSON contiene "apiExterna": "JSONPlaceholder"
```

---

## 📋 REQUISITOS DEL PROYECTO

- [x] **Levantar un servicio**
  - ✅ Spring Boot ejecutándose en puerto 8080
  - ✅ Accesible en http://localhost:8080

- [x] **Con autenticación**
  - ✅ OAuth2 + JWT implementado
  - ✅ Generación de tokens RS256
  - ✅ Validación de tokens
  - ✅ Usuarios: user/password

- [x] **Que consuma una API REST gratuita**
  - ✅ RestTemplate configurado
  - ✅ JSONPlaceholder consumida
  - ✅ Manejo de excepciones

- [x] **Que muestre "Hola Mundo" en formato JSON**
  - ✅ Campo "mensaje": "Hola Mundo"
  - ✅ Formato JSON válido
  - ✅ Información adicional (usuario, timestamp, etc.)

- [x] **SOLO SI ESTÁ AUTENTICADO**
  - ✅ Endpoint bajo /api/** (protegido)
  - ✅ Requiere token JWT válido
  - ✅ Devuelve 401 sin token

---

## 🚀 CÓMO EMPEZAR

### Opción A: Leer y Ejecutar (RECOMENDADO)
1. Lee [RUNBOOK.md](RUNBOOK.md) (5-10 min)
2. Ejecuta los comandos paso a paso
3. Verifica que funciona

### Opción B: Solo Ejecutar (Rápido)
1. Terminal 1: `mvn spring-boot:run` en demoOAUTH2-master/
2. Terminal 2: Copia un ejemplo de [EJEMPLOS.md](EJEMPLOS.md)
3. Pega el comando y ejecútalo

### Opción C: Entender Todo
1. Lee [README.md](README.md) - contexto
2. Lee [ESTRUCTURA.md](ESTRUCTURA.md) - arquitectura
3. Abre los archivos .java del proyecto
4. Ejecuta siguiendo [RUNBOOK.md](RUNBOOK.md)

---

## 🔍 MAPA CONCEPTUAL

```
┌─ CLIENTE ───────────────────────────────┐
│ (curl / Postman / Navegador)            │
└─ Envia usuario/contraseña ─────┬────────┘
                                  │
                                  ▼
┌─ SERVIDOR ──────────────────────────────┐
│                                         │
│ AuthController.login()                  │
│ ├─ Valida credenciales                  │
│ ├─ Genera JWT RS256                     │
│ └─ Devuelve token                       │
│                                         │
│ SecurityFilterChain                     │
│ ├─ Valida JWT en endpoint protegido     │
│ ├─ Si válido → permitir acceso          │
│ └─ Si inválido → 401 Unauthorized       │
│                                         │
│ DataController.getHolaMundo()           │
│ ├─ ApiService.getHolaMundo()            │
│ │  ├─ Consume JSONPlaceholder API       │
│ │  └─ Construye respuesta JSON          │
│ └─ Agrega usuario a la respuesta        │
│                                         │
└─────────────────────────────────────────┘
                │
                ▼
        Devuelve JSON con
        "Hola Mundo"
```

---

## ❓ PREGUNTAS FRECUENTES

**P: ¿Por qué necesito token?**  
R: Para proteger el endpoint y asegurar que solo usuarios autenticados accedan.

**P: ¿Cuánto dura el token?**  
R: 1 hora. Después necesitas hacer login nuevamente.

**P: ¿Puedo cambiar la contraseña?**  
R: Sí, en SecurityConfig.java, método userDetailsService()

**P: ¿Qué pasa si pierdo el token?**  
R: Haz login de nuevo en /api/auth/login

**P: ¿Puedo usar otra API?**  
R: Sí, cambia la URL en ApiService.java línea 21

---

## 📞 SOPORTE

### Si algo no funciona

1. **Puerto 8080 ocupado?**
   - Verifica: `lsof -i :8080`
   - Cierra otro proceso o usa otro puerto

2. **Maven no encuentra dependencias?**
   - Ejecuta: `mvn clean install`
   - Borra la carpeta `.m2` si persiste

3. **Token inválido/expirado?**
   - Haz login nuevamente
   - Verifica que incluyas el header: `Authorization: Bearer TOKEN`

4. **401 Unauthorized?**
   - Verifica que enviaste el token
   - Verifica que sea en formato: `Bearer {token}`
   - Obtén un nuevo token

---

## 📦 DESCARGAS/ACCESO

```
Ruta principal: /workspaces/actividad_2/

Proyecto Maven: demoOAUTH2-master/
Documentación: *.md (este directorio)
Ejemplos: EJEMPLOS.md, RUNBOOK.md
Scripts: *.sh (opcional)
JSON refs: ejemplos.json
```

---

## ✅ CHECKLIST FINAL

Antes de decir que está listo:

- [x] Proyecto compila sin errores
- [x] Servicio se levanta en puerto 8080
- [x] Login devuelve token JWT válido
- [x] Endpoint protegido devuelve 401 sin token
- [x] Endpoint devuelve "Hola Mundo" en JSON
- [x] Consume API externa (JSONPlaceholder)
- [x] Solo accesible si está autenticado
- [x] Documentación completa
- [x] Ejemplos de uso incluidos
- [x] Scripts helper incluidos

**🎉 PROYECTO COMPLETADO Y FUNCIONAL**

---

**Última actualización**: 2 de Mayo de 2026
**Estado**: ✅ Listo para producción de prueba
