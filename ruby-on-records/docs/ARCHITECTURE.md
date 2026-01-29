# 🏗️ Arquitectura Técnica - Ruby On Records

<div align="center">

*Decisiones de diseño, patrones implementados y justificaciones técnicas*

<img src="https://media.giphy.com/media/26tn33aiTi1jkl6H6/giphy.gif" width="300" alt="Architecture">

</div>

---

## 📑 Índice

1. [Visión General](#-visión-general)
2. [Stack Tecnológico](#-stack-tecnológico)
3. [Arquitectura MVC](#-arquitectura-mvc)
4. [Decisiones de Diseño](#-decisiones-de-diseño)
5. [Patrones Implementados](#-patrones-implementados)
6. [Estructura del Proyecto](#-estructura-del-proyecto)
7. [Sistema de Autenticación](#-sistema-de-autenticación)
8. [Sistema de Autorización](#-sistema-de-autorización)
9. [Frontend y Estilos](#-frontend-y-estilos)

---

## 🎯 Visión General

Ruby On Records sigue una arquitectura **monolítica** basada en el patrón **MVC** de Ruby on Rails, dividida en dos áreas:

```
╔══════════════════════════════════════════════════════════════════╗
║                       RUBY ON RECORDS                             ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                   ║
║   ┌─────────────────────┐    ┌─────────────────────────────┐     ║
║   │     STOREFRONT      │    │         BACKSTORE           │     ║
║   │     (Público)       │    │      (Administración)       │     ║
║   ├─────────────────────┤    ├─────────────────────────────┤     ║
║   │                     │    │                             │     ║
║   │  • Home             │    │  • Dashboard                │     ║
║   │  • Catálogo         │    │  • CRUD Discos              │     ║
║   │  • Detalle disco    │    │  • Registro de Ventas       │     ║
║   │  • Login            │    │  • Gestión de Clientes      │     ║
║   │                     │    │  • Gestión de Géneros       │     ║
║   │                     │    │  • Gestión de Usuarios      │     ║
║   └─────────────────────┘    └─────────────────────────────┘     ║
║                                                                   ║
╠══════════════════════════════════════════════════════════════════╣
║                        CAPA DE DATOS                              ║
║   ┌─────────────────────────────────────────────────────────┐    ║
║   │  User │ Disk │ Genre │ Client │ Sale │ Item              │    ║
║   └─────────────────────────────────────────────────────────┘    ║
╚══════════════════════════════════════════════════════════════════╝
```

---

## 💎 Stack Tecnológico

### Backend

| Componente | Tecnología | Justificación |
|:----------:|:----------:|---------------|
| ![Ruby](https://img.shields.io/badge/-Ruby_3.4-CC342D?style=flat-square&logo=ruby&logoColor=white) | Ruby 3.4 | Lenguaje expresivo y productivo |
| ![Rails](https://img.shields.io/badge/-Rails_8.0-CC0000?style=flat-square&logo=rubyonrails&logoColor=white) | Rails 8.0 | Framework maduro con "baterías incluidas" |
| ![Puma](https://img.shields.io/badge/-Puma-000000?style=flat-square) | Puma | Servidor HTTP rápido y eficiente |

### Frontend

| Componente | Tecnología | Justificación |
|:----------:|:----------:|---------------|
| ![Tailwind](https://img.shields.io/badge/-Tailwind_4-38B2AC?style=flat-square&logo=tailwind-css&logoColor=white) | Tailwind CSS 4 | Utility-first para prototipado rápido |
| ![JS](https://img.shields.io/badge/-JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black) | Vanilla JS | Sin frameworks adicionales, máxima simplicidad |

### Base de Datos

| Componente | Tecnología | Justificación |
|:----------:|:----------:|---------------|
| ![SQLite](https://img.shields.io/badge/-SQLite-003B57?style=flat-square&logo=sqlite&logoColor=white) | SQLite 3 | Cero configuración, ideal para desarrollo |

### Seguridad

| Componente | Tecnología | Justificación |
|:----------:|:----------:|---------------|
| 🔐 | bcrypt | Hash de contraseñas seguro |
| 🛡️ | CanCanCan | Autorización centralizada y declarativa |

---

## 🔄 Arquitectura MVC

```
┌─────────────┐     Request      ┌──────────────────┐
│   Browser   │ ───────────────▶ │    Controller    │
└─────────────┘                  └──────────────────┘
       ▲                                │    │
       │                                │    │ Consulta/
       │         Response               │    │ Modifica
       │                                ▼    ▼
┌─────────────┐     Render       ┌──────────────────┐
│    View     │ ◀─────────────── │      Model       │
└─────────────┘                  └──────────────────┘
                                         │
                                         ▼
                                 ┌──────────────────┐
                                 │    Database      │
                                 └──────────────────┘
```

### Flujo de una Request

1. 📡 Usuario hace request desde el navegador
2. 🛤️ Router dirige a controller/action correspondiente
3. 🧠 Controller consulta/modifica modelos
4. 💾 Modelos interactúan con la base de datos
5. 📦 Controller prepara datos y renderiza vista
6. 🎨 Vista genera HTML con los datos
7. 📤 Response se envía al navegador

---

## 🎯 Decisiones de Diseño

### ¿Por qué Rails 8?

| Pros | Detalles |
|------|----------|
| ✅ Productividad | Convención sobre configuración |
| ✅ Madurez | Framework probado en producción |
| ✅ Comunidad | Amplia documentación y gems |
| ✅ Full-stack | Todo incluido sin configuración extra |

> **Decisión**: Rails nos permite desarrollar rápido manteniendo buenas prácticas sin configuración excesiva.

---

### ¿Por qué JavaScript vanilla en vez de Hotwire/Turbo?

| Contexto | Decisión |
|----------|----------|
| 🔄 Formulario de ventas complejo | JavaScript puro con `fetch` |
| ❌ Turbo Frames/Streams | Demasiada complejidad para el caso de uso |

**Justificación técnica:**

```javascript
// Enfoque adoptado: Simple y predecible
function searchClient() {
  fetch('/admin/sales/search_client?dni=' + dni)
    .then(response => response.json())
    .then(data => {
      // Actualizar DOM directamente
    });
}
```

> **Lección aprendida**: Hotwire es excelente para casos simples, pero para formularios dinámicos complejos (agregar/quitar items, búsquedas anidadas), JavaScript vanilla ofrece más control y es más fácil de debuggear.

---

### ¿Por qué CanCanCan?

| Alternativa | Por qué no |
|-------------|------------|
| Pundit | Más disperso (un archivo por modelo) |
| Custom | Más código, menos mantenible |
| **CanCanCan** ✅ | Centralizado en `ability.rb` |

```ruby
# Un solo archivo define TODOS los permisos
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.admin?
      can :manage, :all
    elsif user.gerente?
      can :manage, [Disk, Sale, Client, Genre]
    else
      can :read, [Disk, Sale, Client]
      can :create, [Sale, Client]
    end
  end
end
```

---

### ¿Por qué SQLite?

| Contexto | Decisión |
|----------|----------|
| 🎓 Proyecto académico | No requiere producción |
| 🚀 Development | Cero configuración |
| 📦 Portabilidad | Un solo archivo |

> **Nota**: Para producción se migraría fácilmente a PostgreSQL.

---

### ¿Por qué Tailwind CSS 4?

| Ventaja | Detalle |
|---------|---------|
| ⚡ Rápido | Prototipado veloz con utilities |
| 🎨 Customizable | CSS variables para tema retro |
| 📦 Pequeño | PurgeCSS elimina código no usado |
| 🛠️ Mantenible | Sin colisiones de nombres |

```css
/* Tema personalizado retro */
@theme {
  --color-vinyl-black: #1a1a1a;
  --color-cream: #f5f0e6;
  --color-mustard: #d4a039;
  --color-rust: #a65d57;
  --color-teal: #4a8f8f;
}
```

---

## 🏛️ Patrones Implementados

### 1. Service Objects

Para lógica de negocio compleja, usamos Service Objects:

```ruby
# app/services/sales/creator.rb
module Sales
  class Creator
    def initialize(sale_params, user)
      @sale_params = sale_params
      @user = user
    end

    def call
      build_sale
      return failure unless valid?
      
      ActiveRecord::Base.transaction do
        calculate_total
        @sale.save!
        decrement_stock
      end
      
      success
    end
  end
end
```

**¿Por qué?**
- 🧹 Controllers delgados
- 🧪 Fácil de testear
- 🔄 Reutilizable

---

### 2. Scopes en Modelos

```ruby
# app/models/disk.rb
class Disk < ApplicationRecord
  scope :in_stock, -> { where("stock > 0") }
  scope :by_format, ->(format) { where(format: format) if format.present? }
  scope :search, ->(query) { search_in_fields(query, %w[title artist]) }
end
```

**¿Por qué?**
- 📝 Consultas legibles
- 🔗 Encadenables
- 🎯 Expresivas

---

### 3. Concerns para Código Compartido

```ruby
# app/models/concerns/searchable.rb
module Searchable
  extend ActiveSupport::Concern

  class_methods do
    def search_in_fields(query, fields)
      return all if query.blank?
      # Lógica de búsqueda reutilizable
    end
  end
end
```

---

### 4. Partials para Vistas DRY

```erb
<!-- app/views/shared/_disk_card.html.erb -->
<div class="card-retro">
  <%= image_tag disk.cover %>
  <h3><%= disk.title %></h3>
  <p><%= disk.artist %></p>
</div>

<!-- Uso en cualquier vista -->
<%= render 'shared/disk_card', disk: @disk %>
```

---

## 📁 Estructura del Proyecto

```
app/
├── controllers/
│   ├── admin/                    # 💼 Backstore
│   │   ├── base_controller.rb    # Herencia común (layout, auth)
│   │   ├── disks_controller.rb
│   │   ├── sales_controller.rb   # Endpoints JSON para JS
│   │   ├── clients_controller.rb
│   │   └── genres_controller.rb
│   │
│   ├── application_controller.rb # 🔐 Auth helpers
│   ├── disks_controller.rb       # 🌐 Catálogo público
│   └── sessions_controller.rb    # 🔑 Login/Logout
│
├── models/
│   ├── concerns/
│   │   └── searchable.rb         # 🔍 Búsqueda reutilizable
│   ├── ability.rb                # 🛡️ Permisos (CanCanCan)
│   ├── disk.rb
│   ├── sale.rb
│   └── ...
│
├── services/
│   └── sales/
│       ├── creator.rb            # ⚙️ Crear venta
│       └── canceller.rb          # ⚙️ Cancelar venta
│
└── views/
    ├── layouts/
    │   ├── application.html.erb  # 🎨 Layout público
    │   └── admin.html.erb        # 🎨 Layout admin
    └── ...
```

---

## 🔐 Sistema de Autenticación

### Flujo

```
┌──────────────────┐
│   GET /login     │
│ Mostrar form     │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ POST /login      │
│ email + password │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐     ┌─────────────────┐
│ User.find_by     │────▶│ user.authenticate│
│ (email)          │     │ (password)       │
└──────────────────┘     └────────┬────────┘
                                  │
                         ┌────────┴────────┐
                         │                 │
                       ✅ true           ❌ false
                         │                 │
                         ▼                 ▼
              ┌──────────────────┐  ┌──────────────┐
              │ session[:user_id]│  │ Flash error  │
              │ = user.id        │  │ Re-render    │
              └──────────────────┘  └──────────────┘
```

### Implementación

```ruby
class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_root_path, notice: "¡Bienvenido!"
    else
      flash.now[:alert] = "Credenciales incorrectas"
      render :new
    end
  end
end
```

---

## 🛡️ Sistema de Autorización

### Roles

| Rol | Nivel | Permisos |
|:---:|:-----:|----------|
| 👤 | Empleado | Leer todo, crear ventas y clientes |
| 📊 | Gerente | + Gestionar discos, géneros |
| 👑 | Admin | Acceso total |

### Uso en Controllers

```ruby
class Admin::DisksController < Admin::BaseController
  # Carga automática + verificación de permisos
  before_action :set_disk, only: [:show, :edit, :update, :destroy]
  
  def create
    # authorize! se llama automáticamente
  end
end
```

### Uso en Vistas

```erb
<% if can? :create, Disk %>
  <%= link_to "Nuevo Disco", new_admin_disk_path %>
<% end %>

<% if can? :destroy, @disk %>
  <%= button_to "Eliminar", [:admin, @disk], method: :delete %>
<% end %>
```

---

## 🎨 Frontend y Estilos

### Compilación de Tailwind

```bash
# Desarrollo (watch mode)
bin/dev  # Usa Procfile.dev

# Producción
rails tailwindcss:build
```

### Componentes Custom

```css
/* Botones */
.btn-primary {
  @apply px-6 py-3 bg-mustard text-vinyl-black 
         font-bold uppercase tracking-wider 
         border-2 border-vinyl-black 
         shadow-retro hover:shadow-retro-lg 
         transition-all;
}

/* Cards */
.card-retro {
  @apply bg-paper border-2 border-vinyl-black 
         shadow-retro;
}

/* Vinyl spinning animation */
.vinyl-record {
  animation: spin 2s linear infinite paused;
}
.vinyl-record:hover {
  animation-play-state: running;
}
```

---
