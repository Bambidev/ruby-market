# 📋 Funcionalidades - Ruby On Records

<div align="center">

*Listado completo de características implementadas*

</div>

---

## 🌐 Área Pública (Storefront)

### 🏠 Página de Inicio
- Hero section con mensaje de bienvenida
- Destacados del catálogo
- Acceso rápido a categorías

### 📀 Catálogo de Discos
- **Grid responsive** de productos
- **Filtros avanzados**:
  - 🔍 Búsqueda por texto (título, artista)
  - 🎸 Filtro por género musical
  - 📅 Filtro por año de lanzamiento
  - 💿 Filtro por formato (CD / Vinilo)
  - ✨ Filtro por estado (Nuevo / Usado)
- **Paginación** automática
- **Contador** de resultados

### 🎵 Detalle de Disco
- Imagen de portada con efecto hover
- Información completa (artista, año, descripción)
- **Géneros como burbujas** clickeables
- Preview de audio (si disponible)
- **Carrusel de imágenes** (portada + fotos adicionales)
- Indicador de stock
- Precio destacado
- **Productos relacionados** por género (hasta 5 recomendaciones)

---

## 🔐 Área Privada (Backstore)

### 📊 Dashboard
- Estadísticas generales
- Accesos rápidos a cada módulo
- Resumen de actividad reciente

### 💿 Gestión de Discos

| Acción | Descripción |
|--------|-------------|
| **Listar** | Grid con filtros (género, formato, estado, año, stock) |
| **Crear** | Formulario con validaciones y selección múltiple de géneros |
| **Editar** | Modificar todos los campos incluyendo imágenes |
| **Ver** | Detalle completo con géneros como badges y datos de auditoría |
| **Eliminar** | **Soft delete** - marca como dado de baja sin eliminar físicamente |

**Campos del disco:**
- Título, Artista, Año, Descripción
- Precio, Stock
- Formato (CD / Vinilo)
- Estado (Nuevo / Usado)
- Géneros (múltiples)
- Portada, Fotos adicionales, Preview de audio
- `deleted_at` (para soft delete)

### 🛒 Gestión de Ventas

| Acción | Descripción |
|--------|-------------|
| **Registrar venta** | Formulario dinámico con búsqueda de cliente y discos |
| **Listar ventas** | Tabla con estado, fecha, cliente, productos, total |
| **Ver detalle** | Información completa de la transacción |
| **Cancelar** | Devuelve stock automáticamente |
| **Generar PDF** | Factura profesional descargable |

**Flujo de venta:**
1. Buscar cliente por DNI (o crear nuevo)
2. Agregar productos buscando por título/artista
3. Ajustar cantidades
4. Total calculado en tiempo real
5. Confirmar venta
6. Stock decrementado automáticamente

### 👥 Gestión de Clientes

| Acción | Descripción |
|--------|-------------|
| **Listar** | Tabla con nombre, DNI, email, teléfono |
| **Crear** | Formulario con validación de DNI único |
| **Editar** | Modificar datos de contacto |
| **Ver** | Historial de compras del cliente |
| **Eliminar** | Solo si no tiene compras asociadas |

### 🎸 Gestión de Géneros

| Acción | Descripción |
|--------|-------------|
| **Listar** | Tabla con nombre y cantidad de discos |
| **Crear** | Nombre único |
| **Editar** | Modificar nombre |
| **Ver** | Listado de discos del género |
| **Eliminar** | Solo si no tiene discos asociados |

### 👤 Gestión de Usuarios (Solo Admin/Gerente)

| Acción | Descripción |
|--------|-------------|
| **Listar** | Tabla con nombre, email, rol |
| **Crear** | Asignar rol y credenciales |
| **Editar** | Cambiar rol o datos |
| **Ver** | Detalle con avatar, datos y fecha de registro |
| **Eliminar** | Con confirmación (no permite auto-eliminación) |

---

## 🔒 Sistema de Roles

| Rol | Permisos |
|-----|----------|
| 👤 **Empleado** | Gestionar productos, ventas, clientes, géneros. Ver dashboard |
| 📊 **Gerente** | Todo lo anterior + gestionar usuarios (excepto admins) |
| 👑 **Admin** | Acceso total incluyendo gestión de todos los usuarios |

---

## 🎨 Características de UX/UI

### Diseño Visual
- 🎨 **Paleta retro** inspirada en los 70s/80s
- 📜 **Tipografía display** (Playfair Display + Space Mono)
- 🔲 **Bordes gruesos** y sombras estilo vintage
- 💿 **Animaciones de vinilo** girando

### Interactividad
- ⚡ **Búsquedas instantáneas** con JavaScript
- 🔄 **Cálculos en tiempo real** (totales, subtotales)
- ✅ **Validaciones frontend y backend**
- 💬 **Mensajes flash** para feedback

### Responsive
- 📱 Mobile-first design
- 🖥️ Optimizado para desktop
- 📊 Tablas con scroll horizontal

---

## 🧾 Facturación

### PDF de Venta
- Logo y datos de la tienda
- Datos del cliente
- Tabla de productos con:
  - Cantidad
  - Descripción
  - Precio unitario
  - Subtotal
- Total general
- Número de factura
- Fecha y hora

---

## ⚙️ Funcionalidades Técnicas

### Stock
- ✅ Decremento automático al confirmar venta
- ✅ Incremento automático al cancelar venta
- ✅ Validación de disponibilidad antes de vender
- ✅ Indicador visual de agotado

### Búsqueda
- 🔍 Full-text en título y artista
- 🔍 Scope reutilizable en modelos
- 🔍 Case-insensitive

### Validaciones
- ✅ Presencia de campos requeridos
- ✅ Unicidad (DNI de cliente, email de usuario)
- ✅ Formato (email válido)
- ✅ Numéricos (precio >= 0, stock >= 0)
- ✅ Inclusión (formato in [CD, Vinilo])

---

<div align="center">

**Total: 50+ funcionalidades implementadas** 🚀

</div>