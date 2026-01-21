# Ruby On Records
_______________
  /                 \
 /    ___________    \
|   /   RUBY ON  \   |
|  |    RECORDS   |  |
|   \      *     /   |
 \    -----------   /
  \                /
    ---------------
**Tu tienda de vinilos y CDs desde 1985** Ruby On Records es un sistema de gestion para una disqueria, desarrollado con Ruby on Rails. Permite administrar el inventario de discos, gestionar ventas y clientes, con un sistema de roles y permisos para diferentes tipos de usuarios. --- ## Capturas de Pantalla ### Storefront (Tienda)
+------------------------------------------------------------------+
|  [*] Ruby On Records     INICIO  CATALOGO  NUEVOS  USADOS        |
+==================================================================+
|                                                                  |
|     "Spin Your Story"              _______________               |
|                                  /                 \             |
|     Descubri nuestra            /    ___________    \            |
|     coleccion de vinilos       |   /             \   |           |
|     y CDs...                   |  |    LABEL      |  |           |
|                                |   \      *      /   |           |
|     [EXPLORAR CATALOGO]         \    -----------   /             |
|     [NUEVOS INGRESOS]            \                /              |
|                                    ---------------               |
+------------------------------------------------------------------+
|                                                                  |
|     Nuevos Ingresos                                              |
|     +--------+  +--------+  +--------+  +--------+               |
|     | Album  |  | Album  |  | Album  |  | Album  |               |
|     | Cover  |  | Cover  |  | Cover  |  | Cover  |               |
|     +--------+  +--------+  +--------+  +--------+               |
|     Artist      Artist      Artist      Artist                   |
|     $20,000     $15,000     $70,000     $20,000                  |
|                                                                  |
+------------------------------------------------------------------+
### Backstore (Administracion)
+------------------------------------------------------------------+
|  [*] Backstore     DASHBOARD  DISCOS  VENTAS  CLIENTES  GENEROS  |
+==================================================================+
|                                                                  |
|     Dashboard                                                    |
|                                                                  |
|     +------------+  +------------+  +------------+               |
|     | DISCOS     |  | VENTAS     |  | CLIENTES   |               |
|     |    125     |  |     48     |  |     32     |               |
|     +------------+  +------------+  +------------+               |
|                                                                  |
|     Ultimos Discos Agregados                                     |
|     +------+------------------+----------+--------+              |
|     | ID   | Titulo           | Artista  | Precio |              |
|     +------+------------------+----------+--------+              |
|     | 5    | Alma de Diamante | Spinetta | $150k  |              |
|     | 4    | Jessico          | Babas... | $20k   |              |
|     +------+------------------+----------+--------+              |
|                                                                  |
+------------------------------------------------------------------+
--- ## Caracteristicas Principales - **Catalogo Publico** - Los visitantes pueden explorar el catalogo de discos sin necesidad de registrarse - **Sistema de Roles** - Tres niveles de acceso: Empleado, Gerente y Administrador - **Gestion de Inventario** - CRUD completo de discos (vinilos y CDs) - **Gestion de Ventas** - Registro de ventas con detalle de items - **Gestion de Clientes** - Base de datos de clientes - **Generos Musicales** - Clasificacion de discos por genero - **Diseno Retro** - Interfaz visual inspirada en disquerias de los 70s/80s --- ## Tecnologias | Categoria | Tecnologia | |-----------|------------| | Backend | Ruby on Rails 8.1 | | Frontend | Tailwind CSS v4 | | Base de Datos | SQLite3 | | Autenticacion | has_secure_password (bcrypt) | | Autorizacion | CanCanCan | | JavaScript | Hotwire (Turbo + Stimulus) | | Assets | Propshaft | --- ## Inicio Rapido
Para una guia completa de instalacion, ver [docs/SETUP.md](docs/SETUP.md). ### Usuarios de Prueba | Rol | Email | Password | |-----|-------|----------| | Admin | admin@rubyonrecords.com | admin123 | | Gerente | gerente@rubyonrecords.com | gerente123 | | Empleado | empleado@rubyonrecords.com | empleado123 | --- ## Documentacion | Documento | Descripcion | |-----------|-------------| | [SETUP.md](docs/SETUP.md) | Guia completa de instalacion y comandos utiles | | [FEATURES.md](docs/FEATURES.md) | Lista de funcionalidades | | [ARCHITECTURE.md](docs/ARCHITECTURE.md) | Arquitectura tecnica | | [DATA_MODEL.md](docs/DATA_MODEL.md) | Modelo de datos y permisos | | [DESIGN_SYSTEM.md](docs/DESIGN_SYSTEM.md) | Sistema de diseno visual | --- ## Estructura del Proyecto
ruby-on-records/
├── app/
│   ├── assets/tailwind/     # Estilos CSS custom
│   ├── controllers/         # Logica de controladores
│   │   └── admin/           # Controladores del backstore
│   ├── models/              # Modelos y logica de negocio
│   └── views/               # Vistas y templates
├── config/                  # Configuracion de Rails
├── db/                      # Migraciones y seeds
├── docs/                    # Documentacion del proyecto
└── public/                  # Archivos estaticos
--- ## Modelo de Datos
User ----< Sale >---- Client
             |
             |
           Item
             |
             v
Disk >----< Genre
     (N:M)
- **User**: Empleados del sistema con roles (empleado/gerente/admin) - **Disk**: Productos (vinilos y CDs) - **Genre**: Generos musicales - **Client**: Clientes de la tienda - **Sale**: Ventas realizadas - **Item**: Lineas de detalle de cada venta --- ## Roles y Permisos | Rol | Dashboard | Discos | Ventas | Clientes | Generos | Usuarios | |-----|-----------|--------|--------|----------|---------|----------| | Empleado | Ver | Ver | Ver | Ver | Ver | - | | Gerente | Ver | CRUD | CRUD | CRUD | CRUD | - | | Admin | Ver | CRUD | CRUD | CRUD | CRUD | CRUD | --- ## Equipo Desarrollado como proyecto academico. --- ## Licencia Este proyecto es de uso academico. --- <div align="center"> **Ruby On Records** - *Musica para el alma, calidad para los oidos*
♪ ♫ ♪ ♫ ♪ ♫ ♪ ♫ ♪ ♫
</div>  --- ## Indice 1. [Vision General](#1-vision-general) 2. [Stack Tecnologico](#2-stack-tecnologico) 3. [Arquitectura MVC](#3-arquitectura-mvc) 4. [Estructura de Directorios](#4-estructura-de-directorios) 5. [Capa de Modelos](#5-capa-de-modelos) 6. [Capa de Controladores](#6-capa-de-controladores) 7. [Capa de Vistas](#7-capa-de-vistas) 8. [Sistema de Autenticacion](#8-sistema-de-autenticacion) 9. [Sistema de Autorizacion](#9-sistema-de-autorizacion) 10. [Frontend y Estilos](#10-frontend-y-estilos) 11. [Base de Datos](#11-base-de-datos) 12. [Decisiones de Diseno](#12-decisiones-de-diseno) --- ## 1. Vision General Ruby On Records sigue una arquitectura **monolitica** basada en el patron **MVC (Model-View-Controller)** de Ruby on Rails. La aplicacion se divide en dos areas principales:
