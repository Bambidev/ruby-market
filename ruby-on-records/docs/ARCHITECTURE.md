# Ruby On Records - Arquitectura Tecnica

Este documento describe la arquitectura tecnica del sistema, los patrones de diseno utilizados y las decisiones tecnicas tomadas durante el desarrollo.

---

## Indice

1. [Vision General](#1-vision-general)
2. [Stack Tecnologico](#2-stack-tecnologico)
3. [Arquitectura MVC](#3-arquitectura-mvc)
4. [Estructura de Directorios](#4-estructura-de-directorios)
5. [Capa de Modelos](#5-capa-de-modelos)
6. [Capa de Controladores](#6-capa-de-controladores)
7. [Capa de Vistas](#7-capa-de-vistas)
8. [Sistema de Autenticacion](#8-sistema-de-autenticacion)
9. [Sistema de Autorizacion](#9-sistema-de-autenticacion)
10. [Frontend y Estilos](#10-frontend-y-estilos)
11. [Base de Datos](#11-base-de-datos)
12. [Decisiones de Diseno](#12-decisiones-de-diseno)

---

## 1. Vision General

Ruby On Records sigue una arquitectura **monolitica** basada en el patron **MVC (Model-View-Controller)** de Ruby on Rails. La aplicacion se divide en dos areas principales:

```
+------------------------------------------------------------------+
|                         RUBY ON RECORDS                          |
+------------------------------------------------------------------+
|                                                                  |
|   +-------------------------+   +----------------------------+   |
|   |       STOREFRONT        |   |         BACKSTORE          |   |
|   |      (Publico)          |   |     (Administracion)       |   |
|   +-------------------------+   +----------------------------+   |
|   |                         |   |                            |   |
|   | - Home                  |   | - Dashboard                |   |
|   | - Catalogo              |   | - CRUD Discos              |   |
|   | - Detalle producto      |   | - CRUD Ventas              |   |
|   | - Login                 |   | - CRUD Clientes            |   |
|   |                         |   | - CRUD Generos             |   |
|   |                         |   | - CRUD Usuarios (Admin)    |   |
|   +-------------------------+   +----------------------------+   |
|                                                                  |
+------------------------------------------------------------------+
|                        CAPA DE DATOS                             |
|   +----------------------------------------------------------+   |
|   |  User | Disk | Genre | Client | Sale | Item              |   |
|   +----------------------------------------------------------+   |
+------------------------------------------------------------------+
```

---

## 2. Stack Tecnologico

### Backend

| Componente | Tecnologia | Version | Proposito |
|------------|------------|---------|-----------|
| Framework | Ruby on Rails | 8.1.1 | Framework web MVC |
| Lenguaje | Ruby | 3.4.5 | Lenguaje de programacion |
| Servidor | Puma | >= 5.0 | Servidor HTTP |
| Base de Datos | SQLite3 | >= 2.1 | Almacenamiento de datos |

### Frontend

| Componente | Tecnologia | Proposito |
|------------|------------|-----------|
| CSS Framework | Tailwind CSS v4 | Estilos y diseno |
| JavaScript | Hotwire (Turbo + Stimulus) | Interactividad |
| Asset Pipeline | Propshaft | Manejo de assets |
| Import Maps | importmap-rails | JavaScript sin bundler |

### Seguridad

| Componente | Tecnologia | Proposito |
|------------|------------|-----------|
| Autenticacion | has_secure_password + bcrypt | Login seguro |
| Autorizacion | CanCanCan | Control de permisos |

---

## 3. Arquitectura MVC

```
+-------------+     Request      +------------------+
|   Browser   | ---------------> |    Controller    |
+-------------+                  +------------------+
      ^                                |    |
      |                                |    |
      |         Response               |    | Consulta/Modifica
      |                                |    |
      |                                v    v
+-------------+     Render       +------------------+
|    View     | <--------------- |      Model       |
+-------------+                  +------------------+
                                        |
                                        v
                                 +------------------+
                                 |    Database      |
                                 +------------------+
```

### Flujo de una Request

1. Usuario hace request desde el browser
2. Router de Rails dirige a un controller/action
3. Controller consulta/modifica modelos
4. Modelos interactuan con la base de datos
5. Controller prepara datos y renderiza vista
6. Vista genera HTML con los datos
7. Response se envia al browser

---

## 4. Estructura de Directorios

```
ruby-on-records/
├── app/                          # Codigo de la aplicacion
│   ├── assets/
│   │   ├── builds/               # CSS compilado (generado)
│   │   ├── stylesheets/          # Estilos adicionales
│   │   └── tailwind/
│   │       └── application.css   # Configuracion Tailwind + tema
│   │
│   ├── controllers/
│   │   ├── admin/                # Controllers del backstore
│   │   │   ├── base_controller.rb
│   │   │   ├── dashboard_controller.rb
│   │   │   ├── disks_controller.rb
│   │   │   ├── sales_controller.rb
│   │   │   ├── clients_controller.rb
│   │   │   ├── genres_controller.rb
│   │   │   ├── items_controller.rb
│   │   │   └── users_controller.rb
│   │   ├── application_controller.rb
│   │   ├── disks_controller.rb   # Catalogo publico
│   │   ├── sessions_controller.rb
│   │   └── storefront_controller.rb
│   │
│   ├── models/
│   │   ├── ability.rb            # Definicion de permisos
│   │   ├── application_record.rb
│   │   ├── user.rb
│   │   ├── disk.rb
│   │   ├── genre.rb
│   │   ├── client.rb
│   │   ├── sale.rb
│   │   └── item.rb
│   │
│   └── views/
│       ├── layouts/
│       │   ├── application.html.erb  # Layout storefront
│       │   └── admin.html.erb        # Layout backstore
│       ├── admin/
│       │   ├── dashboard/
│       │   ├── disks/
│       │   ├── sales/
│       │   ├── clients/
│       │   ├── genres/
│       │   └── users/
│       ├── disks/                # Catalogo publico
│       ├── sessions/             # Login
│       ├── shared/               # Partials compartidos
│       └── storefront/           # Home
│
├── config/
│   ├── routes.rb                 # Definicion de rutas
│   ├── database.yml              # Configuracion de BD
│   └── application.rb            # Configuracion general
│
├── db/
│   ├── migrate/                  # Migraciones
│   ├── schema.rb                 # Esquema actual
│   └── seeds.rb                  # Datos iniciales
│
└── docs/                         # Documentacion
```

---

## 5. Capa de Modelos

### Diagrama de Clases

```
+------------------+
                   | ApplicationRecord|
                   +------------------+
                             ^
                             |
         +-------------------+-------------------+
         |         |         |         |         |
+-------+--+ +----+---+ +---+----+ +--+-----+ +-+------+
|   User   | |  Disk  | | Genre  | | Client | |  Sale  |
+----------+ +--------+ +--------+ +--------+ +--------+
| full_name| | title  | |genre_  | | name   | |cancelled|
| email    | | artist | |  name  | | dni    | | total  |
| password | | year   | +--------+ +--------+ | user_id|
| role     | | desc   |     ^           ^     |client_id|
+----------+ | price  |     |           |     +--------+
     |       | stock  |     |           |          |
     |       | format |     |           |          |
     |       | state  |     |           |          |
     |       +--------+     |           |          |
     |           |          |           |          |
     |           +----------+           |          |
     |           |disks_genres          |          |
     |           |   (N:M)              |          |
     |                                  |          |
     |       +--------+                 |          |
     +------>|  Sale  |<----------------+          |
             +--------+                            |
                  |                                |
                  | 1:N                            |
                  v                                |
             +--------+                            |
             |  Item  |<---------------------------+
             +--------+
             | amount |
             | sale_id|
             | disk_id|
             +--------+
```

### Responsabilidades de cada Modelo

| Modelo | Responsabilidad |
|--------|-----------------|
| **User** | Autenticacion, roles, relacion con ventas |
| **Disk** | Producto del inventario, validaciones de negocio |
| **Genre** | Clasificacion musical, relacion N:M con discos |
| **Client** | Datos de clientes, relacion con ventas |
| **Sale** | Transaccion de venta, estado, total |
| **Item** | Linea de detalle, cantidad de cada disco |
| **Ability** | Definicion de permisos (CanCanCan) |

### Validaciones

Los modelos implementan validaciones para garantizar integridad de datos:

```ruby
# Ejemplo: Disk
validates :title, presence: true
validates :price, numericality: { greater_than_or_equal_to: 0 }
validates :format, inclusion: { in: %w[CD Vinilo] }
```

---

## 6. Capa de Controladores

### Jerarquia de Controllers

```
ApplicationController
├── StorefrontController      # Home publico
├── DisksController           # Catalogo publico
├── SessionsController        # Login/Logout
│
└── Admin::BaseController     # Base para admin
    ├── Admin::DashboardController
    ├── Admin::SalesController
    ├── Admin::ClientsController
    ├── Admin::GenresController
    ├── Admin::ItemsController
    └── Admin::UsersController
```

### ApplicationController

```ruby
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "No tienes permiso..."
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Debes iniciar sesion"
    end
  end
end
```

### Admin::BaseController

```ruby
class Admin::BaseController < ApplicationController
  before_action :require_login
  layout "admin"
end
```

### Patron de Controllers Admin

Todos los controllers admin usan load_and_authorize_resource de CanCanCan:

```ruby
class Admin::DisksController < Admin::BaseController
  load_and_authorize_resource

  def index
    # @disks ya esta cargado por CanCanCan
  end

  def create
    # @disk ya esta instanciado con params
    if @disk.save
      redirect_to [:admin, @disk], notice: "Disco creado"
    else
      render :new
    end
  end
end
```

---

## 7. Capa de Vistas

### Layouts

| Layout | Uso | Caracteristicas |
|--------|-----|-----------------|
| application.html.erb | Storefront | Header negro, footer, fondo cream |
| admin.html.erb | Backstore | Header burgundy, navegacion admin |

### Estructura de Layout

```erb
<!DOCTYPE html>
<html>
  <head>
    <!-- Meta tags, fonts, CSS -->
  </head>
  <body>
    <header><!-- Navegacion --></header>

    <!-- Flash messages -->
    <% if notice %><div class="..."><%= notice %></div><% end %>
    <% if alert %><div class="..."><%= alert %></div><% end %>

    <main>
      <%= yield %>  <!-- Contenido de la pagina -->
    </main>

    <footer><!-- Pie de pagina --></footer>
  </body>
</html>
```

### Partials Compartidos

| Partial | Ubicacion | Uso |
|---------|-----------|-----|
| _disk_card.html.erb | shared/ | Card de disco en grids |
| _form.html.erb | admin/disks/ | Formulario de disco |

### Helpers de Vista

```erb
<!-- Verificar permisos -->
<% if can? :manage, Disk %>
  <%= link_to "Nuevo Disco", new_admin_disk_path %>
<% end %>

<!-- Usuario actual -->
<%= current_user.full_name %>
```

---

## 8. Sistema de Autenticacion

### Flujo de Login

```
+------------------+
| GET /login       |
| SessionsController#new
+--------+---------+
         |
         v
+------------------+
| Formulario       |
| email + password |
+--------+---------+
         |
         v
+------------------+
| POST /login      |
| SessionsController#create
+--------+---------+
         |
         v
+------------------+
| User.find_by     |
| (email)          |
+--------+---------+
         |
    +----+----+
    |         |
  User      nil
  found    (error)
    |
    v
+------------------+
| user.authenticate|
| (password)       |
+--------+---------+
         |
    +----+----+
    |         |
  true      false
    |       (error)
    v
+------------------+
| session[:user_id]|
| = user.id        |
+------------------+
         |
         v
+------------------+
| Redirect /admin  |
+------------------+
```

### Implementacion

```ruby
class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_root_path, notice: "Bienvenido"
    else
      flash.now[:alert] = "Email o contrasena incorrectos"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Sesion cerrada"
  end
end
```

### Seguridad de Contrasenas

- Las contrasenas se hashean con **bcrypt**
- Nunca se almacena la contrasena en texto plano
- password_digest guarda el hash + salt

---

## 9. Sistema de Autorizacion

### CanCanCan

La autorizacion se centraliza en app/models/ability.rb:

```ruby
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    # Todos los logueados
    can :read, [Disk, Genre, Client, Sale, Item]
    can :read, :dashboard

    # Gerente+
    if user.gerente? || user.admin?
      can :manage, [Disk, Sale, Client, Genre, Item]
    end

    # Admin
    if user.admin?
      can :manage, :all
    end
  end
end
```

### Integracion con Controllers

```ruby
class Admin::DisksController < Admin::BaseController
  load_and_authorize_resource
  # Automaticamente:
  # 1. Carga @disk/@disks
  # 2. Llama authorize!
  # 3. Lanza AccessDenied si no tiene permiso
end
```

### Integracion con Vistas

```erb
<% if can? :create, Disk %>
  <%= link_to "Nuevo", new_admin_disk_path, class: "btn-primary" %>
<% end %>

<% if can? :destroy, @disk %>
  <%= button_to "Eliminar", [:admin, @disk], method: :delete %>
<% end %>
```

---

## 10. Frontend y Estilos

### Tailwind CSS v4

Configuracion en app/assets/tailwind/application.css:

```css
@import "tailwindcss";

@theme {
  --color-vinyl-black: #1a1a1a;
  --color-cream: #f5f0e6;
  --color-mustard: #d4a039;
  /* ... mas colores */
}

/* Componentes custom */
.btn-primary { /* ... */ }
.card-retro { /* ... */ }
.vinyl-record { /* ... */ }
```

### Compilacion de CSS

```bash
# Desarrollo (watch mode)
bin/dev  # Usa Procfile.dev

# Produccion
bin/rails tailwindcss:build
```

### Google Fonts

```html
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=Space+Mono:wght@400;700" rel="stylesheet">
```

---

## 11. Base de Datos

### SQLite3

Para desarrollo y este proyecto academico se usa SQLite:

- Archivo: db/development.sqlite3
- Sin necesidad de servidor externo
- Facil de versionar/resetear

### Migraciones

```bash
# Crear migration
bin/rails generate migration AddFieldToModel field:type

# Ejecutar migraciones
bin/rails db:migrate

# Rollback
bin/rails db:rollback
```

### Seeds

db/seeds.rb crea datos iniciales:

- 37 generos musicales
- 5 discos de ejemplo
- 3 usuarios (admin, gerente, empleado)

---

## 12. Decisiones de Diseno

### Por que Rails 8.1?

- Framework maduro y productivo
- Convencion sobre configuracion
- Baterias incluidas (autenticacion, ORM, etc.)
- Hotwire para interactividad sin SPA

### Por que CanCanCan?

- Patron centralizado de permisos
- Integracion nativa con Rails
- Codigo declarativo y legible
- Un solo archivo (ability.rb) define todo

### Por que Tailwind CSS?

- Utility-first para prototipado rapido
- Customizable via CSS variables
- Sin necesidad de escribir CSS custom extenso
- Buen soporte en Rails 8

### Por que SQLite?

- Proyecto academico, no requiere produccion
- Cero configuracion
- Archivo unico, facil de resetear
- Suficiente para el scope del proyecto

### Por que no API REST separada?

- Aplicacion monolitica es mas simple
- Hotwire provee interactividad suficiente
- Menos complejidad para proyecto academico
- Un solo deploy, un solo repositorio

### Separacion Storefront/Backstore

- **Storefront**: Publico, solo lectura, sin autenticacion
- **Backstore**: Privado, CRUD completo, con roles
- Layouts diferentes para UX clara
- Namespace Admin:: para controllers admin

---

## Diagramas de Secuencia

### Login

```
Browser          SessionsController       User              Database
   |                    |                   |                   |
   |---GET /login------>|                   |                   |
   |<---Form HTML-------|                   |                   |
   |                    |                   |                   |
   |---POST /login----->|                   |                   |
   |   email, password  |                   |                   |
   |                    |---find_by(email)->|                   |
   |                    |                   |---SELECT--------->|
   |                    |                   |<--User record-----|
   |                    |<---user-----------|                   |
   |                    |                   |                   |
   |                    |---authenticate--->|                   |
   |                    |   (password)      |---bcrypt verify---|
   |                    |<---true/false-----|                   |
   |                    |                   |                   |
   |                    |---session[:user_id] = user.id         |
   |<---Redirect /admin-|                   |                   |
```

### Crear Disco (con autorizacion)

```
Browser     DisksController    Ability      Disk         Database
   |              |               |           |              |
   |--GET /new--->|               |           |              |
   |              |--can?(:new)-->|           |              |
   |              |<--true--------|           |              |
   |<--Form HTML--|               |           |              |
   |              |               |           |              |
   |--POST------->|               |           |              |
   |  disk_params |               |           |              |
   |              |--can?(:create)|           |              |
   |              |<--true--------|           |              |
   |              |               |--new----->|              |
   |              |               |--save---->|              |
   |              |               |           |--INSERT----->|
   |              |               |           |<--OK---------|
   |<--Redirect---|               |           |              |
```

---

## Conclusiones

La arquitectura de Ruby On Records es simple pero robusta:

1. **MVC clasico** de Rails para claridad y mantenibilidad
2. **Autenticacion propia** con bcrypt (simple y segura)
3. **Autorizacion centralizada** con CanCanCan
4. **Frontend moderno** con Tailwind + Hotwire
5. **Separacion clara** entre storefront y backstore

Esta arquitectura es apropiada para:

- Proyectos academicos
- MVPs y prototipos
- Aplicaciones CRUD medianas
- Equipos que conocen Rails