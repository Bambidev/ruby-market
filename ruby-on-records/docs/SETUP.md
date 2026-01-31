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

---

## 🚀 Instalación Rápida

```bash
# 1. Clonar el repositorio
git clone https://github.com/tu-usuario/ruby-on-records.git
cd ruby-on-records

# 2. Instalar dependencias de Ruby
bundle install

# 3. Configurar base de datos
rails db:setup
# Esto ejecuta: db:create + db:migrate + db:seed

# 4. Iniciar el servidor de desarrollo
bin/dev
```

¡Listo! 🎉 Abre [http://localhost:3000](http://localhost:3000)

---

## 📝 Instalación Detallada

### 1️⃣ Clonar Repositorio

```bash
git clone https://github.com/tu-usuario/ruby-on-records.git
cd ruby-on-records
```

### 2️⃣ Instalar Dependencias

```bash
# Dependencias de Ruby (gems)
bundle install

# Si hay problemas con bcrypt en Windows:
# gem install bcrypt --platform=ruby
```

### 3️⃣ Configurar Base de Datos

```bash
# Crear base de datos
rails db:create

# Ejecutar migraciones
rails db:migrate

# Cargar datos de prueba
rails db:seed
```

**Alternativamente, todo en un comando:**
```bash
rails db:setup
```

### 4️⃣ Iniciar Servidor

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

# Rollback múltiples
rails db:rollback STEP=3
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

### Error: Tailwind no compila

```bash
# Reinstalar tailwindcss-rails
bundle exec rails tailwindcss:install
```

### Error en Windows con bcrypt

```bash
# Instalar versión específica
gem install bcrypt --platform=ruby
bundle install
```

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
    └── cache/               ← Caché de la app
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
- [ ] Repositorio clonado
- [ ] `bundle install` exitoso
- [ ] `rails db:setup` exitoso
- [ ] `bin/dev` corriendo
- [ ] http://localhost:3000 carga correctamente
- [ ] Login con admin funciona

---

*¿Problemas? Abre un issue en el repositorio*

</div>