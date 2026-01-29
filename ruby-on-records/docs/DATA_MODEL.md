# 🗃️ Modelo de Datos - Ruby On Records

<div align="center">

*Entidades, relaciones, validaciones y estructura de la base de datos*

<img src="https://media.giphy.com/media/xT9IgzoKnwFNmISR8I/giphy.gif" width="200" alt="Database">

</div>

---

## 📑 Índice

1. [Diagrama ER](#-diagrama-er)
2. [Entidades](#-entidades)
3. [Relaciones](#-relaciones)
4. [Validaciones](#-validaciones)
5. [Scopes](#-scopes)
6. [Migraciones](#-migraciones)

---

## 📊 Diagrama ER

```
┌─────────────────┐
│      USER       │
├─────────────────┤
│ id              │
│ full_name       │
│ email           │
│ password_digest │
│ role            │
│ created_at      │
└────────┬────────┘
         │ 1
         │
         │ N
┌────────▼────────┐         ┌─────────────────┐
│      SALE       │         │     CLIENT      │
├─────────────────┤         ├─────────────────┤
│ id              │    N    │ id              │
│ user_id     ────┼─────────┤ name            │
│ client_id   ────┼────1────│ dni             │
│ cancelled       │         │ email           │
│ total           │         │ phone           │
│ created_at      │         │ created_at      │
└────────┬────────┘         └─────────────────┘
         │ 1
         │
         │ N
┌────────▼────────┐         ┌─────────────────┐
│      ITEM       │         │      DISK       │
├─────────────────┤         ├─────────────────┤
│ id              │    N    │ id              │
│ sale_id     ────┼─────────┤ title           │
│ disk_id     ────┼────1────│ artist          │
│ amount          │         │ year            │
│ price           │         │ description     │
│ created_at      │         │ price           │
└─────────────────┘         │ stock           │
                            │ format          │
                            │ state           │
                            │ created_at      │
                            └────────┬────────┘
                                     │ N
                                     │
                            ┌────────▼────────┐
                            │  DISKS_GENRES   │
                            │   (join table)  │
                            ├─────────────────┤
                            │ disk_id         │
                            │ genre_id        │
                            └────────┬────────┘
                                     │ N
                                     │
                            ┌────────▼────────┐
                            │     GENRE       │
                            ├─────────────────┤
                            │ id              │
                            │ genre_name      │
                            │ created_at      │
                            └─────────────────┘
```

---

## 📦 Entidades

### 👤 User (Usuario)

Usuarios del sistema con acceso al backstore.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | integer | Primary key |
| `full_name` | string | Nombre completo |
| `email` | string | Email único |
| `password_digest` | string | Hash de contraseña (bcrypt) |
| `role` | integer | Enum: empleado, gerente, admin |
| `created_at` | datetime | Fecha de creación |
| `updated_at` | datetime | Última actualización |

```ruby
class User < ApplicationRecord
  has_secure_password
  has_many :sales
  
  enum :role, { empleado: 0, gerente: 1, admin: 2 }
  
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
end
```

---

### 💿 Disk (Disco)

Productos del inventario: vinilos y CDs.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | integer | Primary key |
| `title` | string | Título del álbum |
| `artist` | string | Artista o banda |
| `year` | integer | Año de lanzamiento |
| `description` | text | Descripción del disco |
| `price` | decimal | Precio de venta |
| `stock` | integer | Unidades disponibles |
| `format` | string | "CD" o "Vinilo" |
| `state` | string | "Nuevo" o "Usado" |
| `created_at` | datetime | Fecha de creación |

**Attachments (Active Storage):**
- `cover` - Imagen de portada
- `photos` - Galería de fotos (múltiples)
- `preview` - Audio de preview

```ruby
class Disk < ApplicationRecord
  has_and_belongs_to_many :genres
  has_many :items
  
  has_one_attached :cover
  has_many_attached :photos
  has_one_attached :preview
  
  validates :title, :artist, :year, :price, :stock, presence: true
  validates :format, inclusion: { in: %w[CD Vinilo] }
  validates :state, inclusion: { in: %w[Nuevo Usado] }
  validates :price, :stock, numericality: { greater_than_or_equal_to: 0 }
end
```

---

### 🎸 Genre (Género)

Categorías musicales para clasificar discos.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | integer | Primary key |
| `genre_name` | string | Nombre del género |
| `created_at` | datetime | Fecha de creación |

```ruby
class Genre < ApplicationRecord
  has_and_belongs_to_many :disks
  
  validates :genre_name, presence: true, uniqueness: true
end
```

---

### 👥 Client (Cliente)

Clientes de la tienda.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | integer | Primary key |
| `name` | string | Nombre completo |
| `dni` | string | Documento único |
| `email` | string | Email (opcional) |
| `phone` | string | Teléfono (opcional) |
| `created_at` | datetime | Fecha de creación |

```ruby
class Client < ApplicationRecord
  has_many :sales
  
  validates :name, presence: true
  validates :dni, presence: true, uniqueness: true
end
```

---

### 🧾 Sale (Venta)

Transacciones de venta.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | integer | Primary key |
| `user_id` | integer | FK al usuario que vendió |
| `client_id` | integer | FK al cliente |
| `cancelled` | boolean | Si fue cancelada |
| `total` | decimal | Total de la venta |
| `created_at` | datetime | Fecha de la venta |

```ruby
class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_many :items, dependent: :destroy
  
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  
  scope :active, -> { where(cancelled: false) }
  scope :cancelled, -> { where(cancelled: true) }
end
```

---

### 📦 Item (Ítem de venta)

Líneas de detalle de cada venta.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `id` | integer | Primary key |
| `sale_id` | integer | FK a la venta |
| `disk_id` | integer | FK al disco |
| `amount` | integer | Cantidad vendida |
| `price` | decimal | Precio al momento de venta |
| `created_at` | datetime | Fecha de creación |

```ruby
class Item < ApplicationRecord
  belongs_to :sale
  belongs_to :disk
  
  validates :amount, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  
  def subtotal
    amount * price
  end
end
```

---

## 🔗 Relaciones

### Diagrama de Relaciones

```
User ────1:N──── Sale ────N:1──── Client
                   │
                   1
                   │
                   N
                 Item ────N:1──── Disk ────N:M──── Genre
```

### Tipos de Relaciones

| Relación | Tipo | Descripción |
|----------|------|-------------|
| User → Sales | 1:N | Un usuario registra muchas ventas |
| Client → Sales | 1:N | Un cliente tiene muchas compras |
| Sale → Items | 1:N | Una venta tiene muchos ítems |
| Disk → Items | 1:N | Un disco puede estar en muchos ítems |
| Disk ↔ Genre | N:M | Muchos a muchos via `disks_genres` |

### Join Table: disks_genres

```ruby
# db/migrate/xxx_create_disks_genres.rb
create_table :disks_genres, id: false do |t|
  t.belongs_to :disk
  t.belongs_to :genre
end

add_index :disks_genres, [:disk_id, :genre_id], unique: true
```

---

## ✅ Validaciones

### Resumen por Modelo

| Modelo | Validación | Detalle |
|--------|------------|---------|
| **User** | `presence` | full_name, email |
| | `uniqueness` | email |
| | `has_secure_password` | password automático |
| **Disk** | `presence` | title, artist, year, price, stock |
| | `numericality` | price >= 0, stock >= 0 |
| | `inclusion` | format in [CD, Vinilo] |
| | `inclusion` | state in [Nuevo, Usado] |
| **Genre** | `presence` | genre_name |
| | `uniqueness` | genre_name |
| **Client** | `presence` | name, dni |
| | `uniqueness` | dni |
| **Sale** | `numericality` | total >= 0 |
| **Item** | `numericality` | amount > 0, price >= 0 |

---

## 🔍 Scopes

### Disk

```ruby
class Disk < ApplicationRecord
  # Filtrar por stock
  scope :in_stock, -> { where("stock > 0") }
  scope :out_of_stock, -> { where(stock: 0) }
  
  # Filtrar por formato
  scope :by_format, ->(format) { 
    where(format: format) if format.present? 
  }
  
  # Filtrar por estado
  scope :by_state, ->(state) { 
    where(state: state) if state.present? 
  }
  
  # Búsqueda de texto
  scope :search, ->(query) {
    return all if query.blank?
    where("LOWER(title) LIKE :q OR LOWER(artist) LIKE :q", 
          q: "%#{query.downcase}%")
  }
end
```

### Sale

```ruby
class Sale < ApplicationRecord
  scope :active, -> { where(cancelled: false) }
  scope :cancelled, -> { where(cancelled: true) }
  scope :recent, -> { order(created_at: :desc) }
end
```

---

## 🔄 Migraciones

### Orden de creación

```bash
# 1. Tablas base
rails g model User full_name:string email:string password_digest:string role:integer
rails g model Genre genre_name:string
rails g model Client name:string dni:string email:string phone:string

# 2. Disco (depende de género via join)
rails g model Disk title:string artist:string year:integer description:text price:decimal stock:integer format:string state:string

# 3. Join table
rails g migration CreateDisksGenres

# 4. Venta (depende de user y client)
rails g model Sale user:references client:references cancelled:boolean total:decimal

# 5. Item (depende de sale y disk)
rails g model Item sale:references disk:references amount:integer price:decimal

# Ejecutar
rails db:migrate
```

---

## 🌱 Seeds

```ruby
# db/seeds.rb

# Usuarios
User.create!(
  full_name: "Administrador",
  email: "admin@rubyonrecords.com",
  password: "admin123",
  role: :admin
)

# Géneros
genres = ["Rock", "Jazz", "Blues", "Pop", "Metal", "Electrónica"]
genres.each { |name| Genre.create!(genre_name: name) }

# Discos de ejemplo
Disk.create!(
  title: "Dark Side of the Moon",
  artist: "Pink Floyd",
  year: 1973,
  description: "Álbum icónico de rock progresivo",
  price: 45000,
  stock: 5,
  format: "Vinilo",
  state: "Nuevo",
  genres: [Genre.find_by(genre_name: "Rock")]
)
```

---

<div align="center">

## 📈 Estadísticas

| Entidad | Campos | Relaciones |
|:-------:|:------:|:----------:|
| User | 5 | 1 |
| Disk | 8 + attachments | 2 |
| Genre | 1 | 1 |
| Client | 4 | 1 |
| Sale | 4 | 3 |
| Item | 4 | 2 |

**Total: 6 modelos, 1 join table**

---

*Modelo de datos v1.0 - Ruby On Records*

</div>