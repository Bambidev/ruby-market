# 🎵 Ruby On Records

<div align="center">

![Ruby](https://img.shields.io/badge/Ruby-3.4-CC342D?style=for-the-badge&logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/Rails-8.0-CC0000?style=for-the-badge&logo=rubyonrails&logoColor=white)
![Tailwind](https://img.shields.io/badge/Tailwind-4.0-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-3-003B57?style=for-the-badge&logo=sqlite&logoColor=white)

**Sistema de gestión para disquerías con estética retro de los 70s/80s**

<img src="https://media.giphy.com/media/tqfS3mgQU28ko/giphy.gif" width="300" alt="Vinyl spinning">

[✨ Demo](#-demo) •
[🚀 Instalación](#-instalación) •
[📖 Documentación](#-documentación) •
[🎨 Screenshots](#-screenshots)

</div>

---

## ✨ ¿Qué es Ruby On Records?

Ruby On Records es un **sistema de gestión completo** para tiendas de discos de vinilo y CDs. Combina funcionalidad moderna con una **estética retro nostálgica** que transporta a los usuarios a la época dorada de las disquerías.

<div align="center">
<img src="https://media.giphy.com/media/l0HlvtIPzPdt2usKs/giphy.gif" width="400" alt="Music vibes">
</div>

### 🎯 Características Principales

| Característica | Descripción |
|----------------|-------------|
| 🛒 **Catálogo Público** | Explora discos con filtros avanzados (género, año, formato, estado) |
| 💼 **Panel Admin** | Gestión completa de inventario, ventas, clientes y usuarios |
| 👥 **Sistema de Roles** | Empleado, Gerente y Administrador con permisos diferenciados |
| 👤 **Mi Perfil** | Cada usuario puede editar sus datos personales (excepto su rol) |
| 🧾 **Facturación PDF** | Genera facturas profesionales para cada venta |
| 📊 **Control de Stock** | Actualización automática al registrar ventas o cancelaciones |
| 🎨 **Diseño Retro** | Interfaz inspirada en disquerías vintage con animaciones sutiles |

---

## 🚀 Instalación

### Prerrequisitos

- Ruby 3.4+
- Node.js 18+ (para Tailwind)
- SQLite3

### Pasos

```bash
# 1. Clonar el repositorio
git clone https://github.com/tu-usuario/ruby-on-records.git
cd ruby-on-records

# 2. Instalar dependencias
bundle install

# 3. Configurar base de datos
rails db:setup

# 4. Iniciar el servidor
bin/devc

# posdata: si no tiene permisos de ejecucion el comando bin/dev utilizar
chmod +x bin/dev
```

### 🔑 Usuarios de prueba

| Rol | Email | Contraseña |
|-----|-------|------------|
| 👑 Admin | `admin@rubyonrecords.com` | `admin123` |
| 📊 Gerente | `gerente@rubyonrecords.com` | `gerente123` |
| 👤 Empleado | `empleado@rubyonrecords.com` | `empleado123` |

---

## 🎨 Screenshots

### 🏠 Storefront (Público)

<table>
<tr>
<td width="50%">

**Home**
> Página de inicio
<img width="850" height="648" alt="image" src="https://github.com/user-attachments/assets/6311b85a-fcaa-43d4-b301-733c07f0d9cf" />

</td>
<td width="50%">

**Catálogo**
> Navegación con filtros por género, año y formato
<img width="833" height="644" alt="image" src="https://github.com/user-attachments/assets/977ba62f-b5eb-469b-b761-380919ae3fcd" />

</td>
</tr>
</table>

### 🔐 Backstore (Admin)

<table>
<tr>
<td width="33%">

**Dashboard**
> Estadísticas y accesos rápidos
<img width="845" height="645" alt="image" src="https://github.com/user-attachments/assets/ea45f3bc-9ac0-458d-85dc-1f1e2f0684a5" />

</td>
<td width="33%">

**Gestión de Ventas**
> Registro con búsqueda de cliente y discos
<img width="859" height="596" alt="image" src="https://github.com/user-attachments/assets/4b5e4846-c025-4c60-9d3c-78608e60ebaa" />

</td>
<td width="33%">

**Inventario**
> CRUD completo con filtros avanzados
<img width="861" height="647" alt="image" src="https://github.com/user-attachments/assets/c3c6dd0a-2ef7-4c64-8ac0-9630f761d90b" />

</td>
</tr>
</table>

---

## 📖 Documentación

| Documento | Descripción |
|-----------|-------------|
| [📐 Arquitectura](docs/ARCHITECTURE.md) | Estructura técnica y decisiones de diseño |
| [🗃️ Modelo de Datos](docs/DATA_MODEL.md) | Entidades, relaciones y validaciones |
| [🎨 Sistema de Diseño](docs/DESIGN_SYSTEM.md) | Paleta de colores, tipografía y componentes |
| [⚙️ Setup](docs/SETUP.md) | Guía detallada de instalación |
| [📋 Features](docs/FEATURES.md) | Listado completo de funcionalidades |

---

## 🏗️ Stack Tecnológico

<div align="center">

| Backend | Frontend | Base de Datos |
|:-------:|:--------:|:-------------:|
| ![Ruby](https://img.shields.io/badge/-Ruby_3.4-CC342D?style=flat-square&logo=ruby&logoColor=white) | ![Tailwind](https://img.shields.io/badge/-Tailwind_4-38B2AC?style=flat-square&logo=tailwind-css&logoColor=white) | ![SQLite](https://img.shields.io/badge/-SQLite-003B57?style=flat-square&logo=sqlite&logoColor=white) |
| ![Rails](https://img.shields.io/badge/-Rails_8.0-CC0000?style=flat-square&logo=rubyonrails&logoColor=white) | ![Hotwire](https://img.shields.io/badge/-Hotwire-FF6B6B?style=flat-square) | |
| ![Puma](https://img.shields.io/badge/-Puma-000000?style=flat-square) | ![JavaScript](https://img.shields.io/badge/-JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black) | |

</div>

### 🔒 Seguridad

- **Autenticación**: `bcrypt` + `has_secure_password`
- **Autorización**: `CanCanCan` con roles (Empleado, Gerente, Admin)
- **CSRF Protection**: Rails nativo

---

## 🎵 Flujo de Trabajo

```
┌─────────────────┐      ┌─────────────────┐     ┌─────────────────┐
│ 📀 STOREFRONT   │     │   🔐 LOGIN      │     │   💼 BACKSTORE  │
│   (Público)     │ ──▶ │   Empleados     │ ──▶ │   (Admin)       │
└─────────────────┘     └─────────────────┘      └─────────────────┘
│                                                │
│  - Ver catálogo                                │  - Gestionar discos
│  - Filtrar discos                              │  - Registrar ventas
│  - Ver detalles                                │  - Admin clientes
                                                 │  - Generar facturas
                                                 │  - Control de stock
```

---

## 🛠️ Comandos Útiles

```bash
# Desarrollo
bin/dev                    # Inicia servidor + Tailwind watch
rails console              # Consola interactiva
rails db:seed              # Cargar datos de prueba

# Base de datos
rails db:reset             # Resetear y re-seedear
rails db:migrate:status    # Ver estado de migraciones
```

---

## 📁 Estructura del Proyecto

```
ruby-on-records/
├── app/
│   ├── controllers/
│   │   ├── admin/          # 💼 Controllers del backstore
│   │   │   └── profile_controller.rb  # 👤 Mi Perfil
│   │   └── ...             # 🌐 Controllers públicos
│   ├── models/             # 🗃️ Modelos y lógica de negocio
│   ├── views/
│   │   ├── admin/          # 💼 Vistas del backstore
│   │   ├── layouts/        # 🎨 Layouts (público y admin)
│   │   └── shared/         # 🔧 Partials compartidos
│   ├── services/           # ⚙️ Service Objects (Sales::Creator)
│   └── helpers/            # 🛠️ View helpers
├── config/
│   └── routes.rb           # 🛤️ Definición de rutas
├── db/
│   ├── migrate/            # 📦 Migraciones
│   ├── seeds.rb            # 🌱 Datos iniciales
│   └── seeds/assets/       # 🖼️ Archivos multimedia para seeds
│       ├── covers/         # Portadas de discos
│       ├── photos/         # Fotos adicionales
│       └── previews/       # Audios de muestra
└── docs/                   # 📖 Documentación técnica
```

### 📂 Seeds con Archivos Multimedia

Los datos de prueba (`rails db:seed`) incluyen discos con imágenes y audios reales. Para que funcionen correctamente:

1. Los archivos se ubican en `db/seeds/assets/`
2. Se organizan en subcarpetas: `covers/`, `photos/`, `previews/`
3. Los nombres de archivo deben coincidir con el título del disco (normalizado):
   - Ejemplo: Disco "Diamonds and Pearls" → `diamonds_and_pearls.jpg`
4. El seed detecta automáticamente y adjunta los archivos correspondientes

```bash
db/seeds/assets/
├── covers/
│   ├── diamonds_and_pearls.jpg
│   ├── wish_you_were_here.jpg
│   └── jessico.jpg
├── photos/
│   ├── diamonds_and_pearls_1.jpg
│   └── diamonds_and_pearls_2.jpg
└── previews/
    └── wish_you_were_here.mp3
```

---

## 🤝 Contribuir

1. Fork el proyecto
2. Crea tu branch (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -m 'Agregar nueva funcionalidad'`)
4. Push al branch (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

---

<div align="center">

**Hecho con ❤️ y 🎵**

*Ruby On Records © 2026*

</div>
