# ⚙️ Guía de Instalación - Ruby On Records

<div align="center">

*Instrucciones paso a paso para configurar el entorno de desarrollo*

<img src="https://media.giphy.com/media/LmNwrBhejkK9EFP504/giphy.gif" width="200" alt="Setup">

</div>

---

## 📋 Prerrequisitos

Antes de comenzar, asegúrate de tener instalado:

| Herramienta | Versión | Verificar |
|:-----------:|:-------:|-----------|
| ![Ruby](https://img.shields.io/badge/-Ruby-CC342D?style=flat-square&logo=ruby&logoColor=white) | 3.4+ | `ruby -v` |
| ![Node](https://img.shields.io/badge/-Node.js-339933?style=flat-square&logo=node.js&logoColor=white) | 18+ | `node -v` |
| ![Git](https://img.shields.io/badge/-Git-F05032?style=flat-square&logo=git&logoColor=white) | 2.0+ | `git --version` |
| ![FFmpeg](https://img.shields.io/badge/-FFmpeg-007808?style=flat-square&logo=ffmpeg&logoColor=white) | 4.0+ | `ffmpeg -version` |

---

## 🚀 Instalación Rápida

```bash
# 1. Instalar FFmpeg (Requerido para análisis de audio/video)
# Ubuntu/WSL: sudo apt install ffmpeg
# MacOS: brew install ffmpeg
# Windows: choco install ffmpeg

# 2. Clonar el repositorio
git clone https://github.com/tu-usuario/ruby-on-records.git
cd ruby-on-records

# 3. Instalar dependencias de Ruby
bundle install

# 4. Configurar base de datos
rails db:setup
# Esto ejecuta: db:create + db:migrate + db:seed

# 5. Iniciar el servidor de desarrollo
bin/dev
```

¡Listo! 🎉 Abre [http://localhost:3000](http://localhost:3000)

---

## 📝 Instalación Detallada

### 1️⃣ Prerrequisitos del Sistema

Es **crítico** tener instalado FFmpeg para que ActiveStorage pueda analizar la duración de los audios y procesar imágenes.

**Ubuntu / WSL / Debian:**
```bash
sudo apt-get update && sudo apt-get install -y ffmpeg
```

**MacOS (Homebrew):**
```bash
brew install ffmpeg
```

**Windows (Chocolatey):**
```powershell
choco install ffmpeg
```

### 2️⃣ Clonar Repositorio

```bash
git clone https://github.com/tu-usuario/ruby-on-records.git
cd ruby-on-records
```

### 3️⃣ Instalar Dependencias

```bash
# Dependencias de Ruby (gems)
bundle install
```

### 4️⃣ Configurar Base de Datos

```bash
# Crear base de datos, migrar y cargar semillas
rails db:setup
```

### 5️⃣ Iniciar Servidor

```bash
# Opción 1: Con Tailwind watch (recomendado)
bin/dev

# Opción 2: Solo Rails (sin hot-reload de CSS)
rails server
```

---



## 🔑 Credenciales de Acceso

Después de ejecutar `db:seed`, tendrás estos usuarios:

| Rol | Email | Contraseña |
|:---:|-------|------------|
| 👑 Admin | `admin@rubyonrecords.com` | `admin123` |
| 📊 Gerente | `gerente@rubyonrecords.com` | `gerente123` |
| 👤 Empleado | `empleado@rubyonrecords.com` | `empleado123` |

---

## 🔧 Comandos Útiles

### Desarrollo

```bash
# Servidor de desarrollo
bin/dev                    # Rails + Tailwind watch

# Consola interactiva
rails console              # o: rails c

# Ver rutas disponibles
rails routes | grep admin  # Filtrar por admin
```

### Base de Datos

```bash
# Resetear BD (drop + create + migrate + seed)
rails db:reset

# Ver estado de migraciones
rails db:migrate:status

# Rollback última migración
rails db:rollback
```

### Tailwind CSS

```bash
# Compilar CSS una vez
rails tailwindcss:build

# Watch mode (ya incluido en bin/dev)
rails tailwindcss:watch
```

### Limpieza

```bash
# Limpiar assets compilados
rails assets:clobber

# Limpiar cache
rails tmp:clear
```

---

## 🐛 Troubleshooting

### Error: "Could not find gem..."

```bash
# Actualizar bundler
gem update bundler
bundle install
```

### Error: "SQLite3::BusyException"

```bash
# Cerrar otras conexiones y resetear
rails db:reset
```

### Error: "Validation failed: Preview..."

Asegúrate de que `ffmpeg` esté instalado y accesible en el PATH. Si estás en WSL, instálalo dentro de WSL, no en Windows.

---

## 📁 Estructura Post-Instalación

```
ruby-on-records/
├── db/
│   ├── development.sqlite3  ← Base de datos creada
│   └── schema.rb            ← Esquema actual
├── storage/
│   └── ...                  ← Archivos subidos (Active Storage)
├── log/
│   └── development.log      ← Logs de desarrollo
└── tmp/
│   └── cache/               ← Caché de la app
```

---

## 🌐 URLs Importantes

| URL | Descripción |
|-----|-------------|
| http://localhost:3000 | Storefront (público) |
| http://localhost:3000/login | Login |
| http://localhost:3000/admin | Dashboard admin |
| http://localhost:3000/admin/disks | Gestión de discos |
| http://localhost:3000/admin/sales | Gestión de ventas |
| http://localhost:3000/admin/clients | Gestión de clientes |
| http://localhost:3000/admin/genres | Gestión de géneros |

---

## 🧪 Tests (Opcional)

```bash
# Ejecutar todos los tests
rails test

# Tests de sistema (con navegador)
rails test:system

# Test específico
rails test test/models/disk_test.rb
```

---

<div align="center">

## ✅ Checklist de Instalación

- [ ] Ruby 3.4+ instalado
- [ ] Node.js 18+ instalado
- [ ] **FFmpeg instalado**
- [ ] Repositorio clonado
- [ ] `bundle install` exitoso
- [ ] `rails db:setup` exitoso
- [ ] `bin/dev` corriendo
- [ ] http://localhost:3000 carga correctamente
- [ ] Login con admin funciona

---

*¿Problemas? Abrí un issue en el repositorio*

</div>