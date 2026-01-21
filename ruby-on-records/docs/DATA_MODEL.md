# Ruby On Records - Modelado de Datos y Permisos

## Descripcion General

Ruby On Records es un sistema de gestion para una tienda de vinilos y CDs. El sistema maneja:

- **Inventario** de discos (vinilos y CDs)
- **Ventas** a clientes
- **Usuarios** internos con diferentes roles y permisos

---

## Diagrama de Entidad-Relacion

```
+----------------+       +------------------+       +----------------+
|     USER       |       |      SALE        |       |    CLIENT      |
|----------------|       |------------------|       |----------------|
| id             |       | id               |       | id             |
| full_name      |       | cancelled        |       | name           |
| email          |<----->| user_id (FK)     |<----->| dni            |
| password_digest|  1:N  | client_id (FK)   |  1:N  +----------------+
| role           |       | total            |
+----------------+       | created_at       |
                         +------------------+
                                |
                                | 1:N
                                v
                         +------------------+
                         |      ITEM        |
                         |------------------|
                         | id               |
                         | sale_id (FK)     |
                         | disk_id (FK)     |
                         | amount           |
                         +------------------+
                                |
                                | N:1
                                v
+----------------+       +------------------+
|     GENRE      |       |      DISK        |
|----------------|       |------------------|
| id             |<----->| id               |
| genre_name     |  N:M  | title            |
+----------------+       | artist           |
         ^                | year             |
         |                | description      |
         +----------------| price            |
          disks_genres    | stock            |
          (join table)    | format           |
                         | state            |
                         +------------------+
```

---

## Modelos

### User (Usuario)

Representa a los empleados del sistema (vendedores, gerentes, administradores).

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| id | integer | Identificador unico |
| full_name | string | Nombre completo |
| email | string | Correo electronico (unico) |
| password_digest | string | Hash de la contrasena (bcrypt) |
| role | integer | Rol del usuario (enum) |
| created_at | datetime | Fecha de creacion |
| updated_at | datetime | Fecha de actualizacion |

**Enum de Roles:**

| Valor | Nombre | Descripcion |
|-------|--------|-------------|
| 0 | empleado | Rol por defecto, solo lectura |
| 1 | gerente | Puede gestionar productos y ventas |
| 2 | admin | Acceso total al sistema |

**Relaciones:**

- has_many :sales - Un usuario puede realizar muchas ventas

**Validaciones:**

- full_name: obligatorio, solo letras
- email: obligatorio, unico, formato valido

---

### Disk (Disco)

Representa un producto en el inventario (vinilo o CD).

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| id | integer | Identificador unico |
| title | string | Titulo del album |
| artist | string | Artista o banda |
| year | integer | Ano de lanzamiento |
| description | text | Descripcion del producto |
| price | float | Precio unitario |
| stock | integer | Cantidad disponible |
| format | string | "CD" o "Vinilo" |
| state | string | "Nuevo" o "Usado" |
| created_at | datetime | Fecha de creacion |
| updated_at | datetime | Fecha de actualizacion |

**Relaciones:**

- has_many :items - Un disco puede estar en varios items de ventas
- has_and_belongs_to_many :genres - Un disco puede tener varios generos

**Validaciones:**

- title: obligatorio
- artist: obligatorio
- year: obligatorio, entre 1870 y ano actual
- description: obligatorio, minimo 10 caracteres
- price: obligatorio, >= 0
- stock: obligatorio, entero >= 0
- format: obligatorio, solo "CD" o "Vinilo"
- state: obligatorio, solo "Nuevo" o "Usado"

---

### Genre (Genero)

Representa un genero musical.

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| id | integer | Identificador unico |
| genre_name | string | Nombre del genero |
| created_at | datetime | Fecha de creacion |
| updated_at | datetime | Fecha de actualizacion |

**Relaciones:**

- has_and_belongs_to_many :disks - Un genero puede tener muchos discos

**Validaciones:**

- genre_name: obligatorio, unico

---

### Client (Cliente)

Representa a los clientes de la tienda.

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| id | integer | Identificador unico |
| name | string | Nombre completo |
| dni | string | Documento de identidad |
| created_at | datetime | Fecha de creacion |
| updated_at | datetime | Fecha de actualizacion |

**Relaciones:**

- has_many :sales - Un cliente puede tener muchas ventas

**Validaciones:**

- name: obligatorio
- dni: obligatorio, unico

---

### Sale (Venta)

Representa una transaccion de venta.

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| id | integer | Identificador unico |
| cancelled | boolean | Si la venta fue cancelada |
| total | float | Total de la venta |
| user_id | integer | FK al usuario que realizo la venta |
| client_id | integer | FK al cliente |
| created_at | datetime | Fecha de creacion |
| updated_at | datetime | Fecha de actualizacion |

**Relaciones:**

- belongs_to :user
- belongs_to :client
- has_many :items

---

### Item (Linea de detalle)

Representa una linea de detalle de una venta.

| Campo | Tipo | Descripcion |
|-------|------|-------------|
| id | integer | Identificador unico |
| amount | integer | Cantidad de discos |
| sale_id | integer | FK a la venta |
| disk_id | integer | FK al disco |
| created_at | datetime | Fecha de creacion |
| updated_at | datetime | Fecha de actualizacion |

**Relaciones:**

- belongs_to :sale
- belongs_to :disk

**Validaciones:**

- amount: obligatorio, entero > 0

---

## Sistema de Permisos

### CanCanCan

```ruby
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?  # Sin login = sin permisos

    # Permisos base (todos los logueados)
    can :read, Disk
    can :read, Genre
    can :read, Client
    can :read, Sale
    can :read, Item
    can :read, :dashboard

    # Gerente y Admin
    if user.gerente? || user.admin?
      can :manage, Disk
      can :manage, Sale
      can :manage, Client
      can :manage, Genre
      can :manage, Item
    end

    # Solo Admin
    if user.admin?
      can :manage, User
      can :manage, :all
    end
  end
end
```

### Matriz de Permisos por Rol

| Recurso | Accion | Empleado | Gerente | Admin |
|---------|--------|----------|---------|-------|
| **Dashboard** | read | SI | SI | SI |
| **Disk** | read | SI | SI | SI |
| **Disk** | create | NO | SI | SI |
| **Disk** | update | NO | SI | SI |
| **Disk** | destroy | NO | SI | SI |
| **Genre** | read | SI | SI | SI |
| **Genre** | create | NO | SI | SI |
| **Genre** | update | NO | SI | SI |
| **Genre** | destroy | NO | SI | SI |
| **Client** | read | SI | SI | SI |
| **Client** | create | NO | SI | SI |
| **Client** | update | NO | SI | SI |
| **Client** | destroy | NO | SI | SI |
| **Sale** | read | SI | SI | SI |
| **Sale** | create | NO | SI | SI |
| **Sale** | update | NO | SI | SI |
| **Sale** | destroy | NO | SI | SI |
| **Item** | read | SI | SI | SI |
| **Item** | create | NO | SI | SI |
| **Item** | update | NO | SI | SI |
| **Item** | destroy | NO | SI | SI |
| **User** | read | NO | NO | SI |
| **User** | create | NO | NO | SI |
| **User** | update | NO | NO | SI |
| **User** | destroy | NO | NO | SI |

### Acciones CanCanCan

| Accion | Metodos HTTP / Controller Actions |
|--------|-----------------------------------|
| :read | GET index, GET show |
| :create | GET new, POST create |
| :update | GET edit, PATCH/PUT update |
| :destroy | DELETE destroy |
| :manage | Todas las anteriores |

---

## Rutas y Control de Acceso

### Rutas Publicas (sin login)

| Ruta | Descripcion |
|------|-------------|
| GET / | Pagina principal (storefront) |
| GET /disks | Catalogo de discos |
| GET /disks/:id | Detalle de un disco |
| GET /login | Formulario de login |
| POST /login | Procesar login |

### Rutas Protegidas (requieren login)

| Ruta | Metodo | Acceso | Descripcion |
|------|--------|--------|-------------|
| DELETE /logout | DELETE | Todos | Cerrar sesion |
| GET /admin | GET | Todos | Dashboard admin |
| GET /admin/disks | GET | Todos | Listar discos |
| GET /admin/disks/:id | GET | Todos | Ver disco |
| GET /admin/disks/new | GET | Gerente+ | Nuevo disco |
| POST /admin/disks | POST | Gerente+ | Crear disco |
| GET /admin/disks/:id/edit | GET | Gerente+ | Editar disco |
| PATCH /admin/disks/:id | PATCH | Gerente+ | Actualizar disco |
| DELETE /admin/disks/:id | DELETE | Gerente+ | Eliminar disco |
| ... | ... | ... | ... |

---

## Flujo de Control de Acceso

```
+------------------+
|  Usuario visita  |
|     /admin       |
+--------+---------+
         |
         v
+--------+---------+
|  Tiene sesion?   |
+--------+---------+
    |         |
   NO        SI
    |         |
    v         v
+--------+  +---------+
| /login |  | Mostrar |
+--------+  | pagina  |
    |       +---------+
    v
+------------------+
| POST /login      |
| email + password |
+--------+---------+
         |
         v
+------------------+
| Credenciales     |
| validas?         |
+--------+---------+
    |         |
   NO        SI
    |         |
    v         v
+--------+  +------------------+
| Error  |  | Crear sesion     |
| login  |  | Redirect /admin  |
+--------+  +------------------+
```

---

## Flujo de Autorizacion

```
+------------------+
| Usuario intenta  |
| accion en admin  |
+--------+---------+
         |
         v
+------------------+
| load_and_        |
| authorize_       |
| resource         |
+--------+---------+
         |
         v
+------------------+
| Ability.new      |
| (current_user)   |
+--------+---------+
         |
         v
+------------------+
| can? :action,    |
|      resource    |
+--------+---------+
    |         |
   NO        SI
    |         |
    v         v
+----------+  +------------------+
| Redirect |  | Ejecutar accion  |
| + Alert  |  | del controller   |
| "Sin     |  +------------------+
| permiso" |
+----------+
```

---

## Usuarios de Prueba

| Rol | Nombre | Email | Password |
|-----|--------|-------|----------|
| Admin | Admin | admin@rubyonrecords.com | admin123 |
| Gerente | Gerente | gerente@rubyonrecords.com | gerente123 |
| Empleado | Empleado | empleado@rubyonrecords.com | empleado123 |

---

## Resumen Visual de Accesos

```
STOREFRONT                    BACKSTORE (Admin)
                     ==========                    =================

+-----------------+    +-----------+                 +-------------------+
|   Publico       |--->| Home      |                 |                   |
| (sin login)     |    | Catalogo  |                 |   LOGIN REQUIRED  |
|                 |    | Detalle   |                 |                   |
+-----------------+    +-----------+                 +-------------------+
                                                           |
                         +------------------+--------------+---------------+
                         |                  |                              |
                         v                  v                              v
                  +-----------+      +-----------+                  +-----------+
                  | EMPLEADO  |      | GERENTE   |                  |   ADMIN   |
                  +-----------+      +-----------+                  +-----------+
                  |           |      |           |                  |           |
                  | Dashboard |      | Dashboard |                  | Dashboard |
                  | (solo ver)|      |           |                  |           |
                  |           |      | Discos    |                  | Discos    |
                  | Discos    |      | (CRUD)    |                  | (CRUD)    |
                  | (ver)     |      |           |                  |           |
                  |           |      | Ventas    |                  | Ventas    |
                  | Ventas    |      | (CRUD)    |                  | (CRUD)    |
                  | (ver)     |      |           |                  |           |
                  |           |      | Clientes  |                  | Clientes  |
                  | Clientes  |      | (CRUD)    |                  | (CRUD)    |
                  | (ver)     |      |           |                  |           |
                  |           |      | Generos   |                  | Generos   |
                  | Generos   |      | (CRUD)    |                  | (CRUD)    |
                  | (ver)     |      |           |                  |           |
                  |           |      |           |                  | Usuarios  |
                  |           |      |           |                  | (CRUD)    |
                  +-----------+      +-----------+                  +-----------+
```

---

## Tecnologias Utilizadas

| Componente | Tecnologia |
|------------|------------|
| Framework | Ruby on Rails 8.1 |
| Base de Datos | SQLite3 |
| Autenticacion | has_secure_password (bcrypt) |
| Autorizacion | CanCanCan |
| Frontend | Tailwind CSS v4 |