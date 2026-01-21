# Ruby On Records - Sistema de Diseno Visual

## Concepto General

**Ruby On Records** es una tienda de vinilos y CDs con una estetica **retro/vintage** inspirada en las disquerias de los anos 70s y 80s. El diseno combina la nostalgia del vinilo con una interfaz moderna y funcional.

### Palabras Clave del Estilo

- Retro
- Vintage
- Nostalgico
- Calido
- Autentico
- Groovy
- Analogico

---

## Paleta de Colores

### Colores Principales

| Nombre | HEX | Uso |
|--------|-----|-----|
| **Vinyl Black** | #1a1a1a | Fondos principales, header, footer, bordes |
| **Vinyl Dark** | #2d2d2d | Fondos secundarios oscuros |
| **Vinyl Groove** | #3d3d3d | Bordes sutiles, separadores |
| **Cream** | #f5f0e6 | Fondo principal claro, textos sobre oscuro |
| **Cream Dark** | #e8e0d0 | Hover sobre cream, fondos alternos |
| **Paper** | #faf8f3 | Fondo de cards y formularios |

### Colores de Acento

| Nombre | HEX | Uso |
|--------|-----|-----|
| **Mustard** | #d4a039 | Color primario de accion, CTAs, destacados |
| **Mustard Dark** | #b8872e | Hover del mustard |
| **Rust** | #c45c3e | Alertas, eliminar, errores |
| **Rust Dark** | #a34830 | Hover del rust |
| **Teal** | #2a9d8f | Exito, confirmaciones |
| **Teal Dark** | #21867a | Hover del teal |
| **Burgundy** | #7d2e4a | Header admin, acentos premium |
| **Burgundy Dark** | #5e2238 | Hover del burgundy |
| **Olive** | #6b7b3a | Badges, etiquetas secundarias |
| **Sepia** | #8b7355 | Texto secundario, placeholders |

### Esquema Visual

```
+--------------------------------------------------+
|  HEADER: Vinyl Black + Mustard border            |
|  Logo: Mustard | Links: Cream -> Mustard hover   |
+--------------------------------------------------+
|                                                  |
|  BODY: Cream background                          |
|                                                  |
|  +------------+  +------------+  +------------+  |
|  |   CARD     |  |   CARD     |  |   CARD     |  |
|  |   Paper    |  |   Paper    |  |   Paper    |  |
|  |   bg       |  |   bg       |  |   bg       |  |
|  +------------+  +------------+  +------------+  |
|                                                  |
|  [BTN PRIMARY]  [BTN SECONDARY]  [BTN DANGER]   |
|    Mustard         Cream           Rust          |
|                                                  |
+--------------------------------------------------+
|  FOOTER: Vinyl Black + Mustard border            |
+--------------------------------------------------+
```

---

## Tipografia

### Fuentes

| Tipo | Fuente | Peso | Uso |
|------|--------|------|-----|
| **Display** | Playfair Display | 400, 700, 900 | Titulos, headings, logo |
| **Body** | Space Mono | 400, 700 | Texto general, navegacion, botones |

### Jerarquia Tipografica

```css
/* Titulos principales */
h1: Playfair Display, 4xl-6xl, bold

/* Subtitulos */
h2: Playfair Display, 3xl-4xl, bold

/* Titulos de seccion */
h3: Playfair Display, 2xl, bold

/* Labels y navegacion */
labels: Space Mono, xs-sm, uppercase, tracking-wider, bold

/* Texto de cuerpo */
body: Space Mono, base, regular
```

### Caracteristicas del Texto

- **Navegacion**: MAYUSCULAS, letter-spacing amplio (tracking-wider)
- **Botones**: MAYUSCULAS, bold, letter-spacing
- **Labels**: MAYUSCULAS, tamano pequeno, bold
- **Titulos**: Serif elegante, tamanos grandes

---

## Componentes

### Botones

#### Estilo Base

Todos los botones comparten:

- Padding: 0.75rem 1.5rem
- Borde: 2px solid #1a1a1a
- Sombra: 3px 3px 0 0 #1a1a1a
- Tipografia: uppercase, bold, tracking-wider
- Hover: Sombra reduce a 1px 1px, translate 2px, 2px
- Active: Sin sombra, translate 3px, 3px

```
Normal:          Hover:           Active:
+--------+       +--------+       +--------+
| BUTTON |###    | BUTTON |#      | BUTTON |
+--------+###    +--------+#      +--------+
  #######          ##
```

#### Variantes

| Variante | Fondo | Texto | Uso |
|----------|-------|-------|-----|
| Primary | Mustard | Vinyl Black | Acciones principales |
| Secondary | Cream | Vinyl Black | Acciones secundarias |
| Danger | Rust | White | Eliminar, cancelar |

### Cards

```
+---------------------------+
|                           |  <- Paper background
|      [Imagen/Vinilo]      |
|                           |
|  Titulo del Album         |  <- Playfair Display, bold
|  Artista                  |  <- Space Mono, sepia
|                           |
|  $1,500                   |  <- Mustard, bold
|  [AGREGAR]                |  <- btn-primary
+---------------------------+
    ######################     <- Sombra offset
```

- Fondo: Paper (#faf8f3)
- Borde: 2px solid #1a1a1a
- Sombra: 4px 4px 0 0 #1a1a1a
- Hover: Sombra aumenta, card se eleva

### Inputs y Formularios

```
ETIQUETA                      <- uppercase, xs, bold, vinyl-dark
+---------------------------+
| Placeholder...            |  <- sepia/50 opacity
+---------------------------+
     2px solid vinyl-black

Focus:
+---------------------------+
| Texto ingresado           |
+===========================+
     2px solid mustard
     + sombra 2px 2px mustard
```

### Tablas

```
+-------+----------+--------+
| HEAD  |   HEAD   |  HEAD  |  <- Vinyl Black bg, Cream text
+-------+----------+--------+
| data  |   data   |  data  |  <- Paper bg
+-------+----------+--------+
| data  |   data   |  data  |  <- Hover: Cream Dark bg
+-------+----------+--------+
```

### Badges

```
+----------+
| ETIQUETA |  <- 2px border, uppercase, xs, bold
+----------+
```

Colores segun contexto:

- Disponible: Teal
- Agotado: Rust
- Nuevo: Mustard
- Usado: Olive

---

## Elemento Iconico: El Vinilo

### Estructura Visual

```
_______________
      /                 \
    /    ___________     \
   |   /             \    |
   |  |    LABEL      |   |   <- Circulo mustard (33% del total)
   |  |    (mustard)  |   |
   |   \      O      /    |   <- Centro negro (8% del total)
    \    -----------     /
      \                 /
        ---------------
            ^ Disco negro con surcos sutiles
```

### CSS del Vinilo

```css
.vinyl-record {
  border-radius: 9999px;
  background-color: #1a1a1a;
  background-image: repeating-radial-gradient(
    circle at center,
    transparent 0, transparent 2px,
    rgba(255,255,255,0.03) 2px,
    rgba(255,255,255,0.03) 4px
  );
}

/* Label central */
.vinyl-record::before {
  width: 33%;
  height: 33%;
  background-color: #d4a039; /* mustard */
  border: 4px solid #2d2d2d;
}

/* Agujero central */
.vinyl-record::after {
  width: 8%;
  height: 8%;
  background-color: #1a1a1a;
}
```

### Animaciones

- **vinyl-spin**: Rotacion continua 360deg en 3s (para hero)
- **vinyl-spin-hover**: Rotacion solo en hover, 2s

---

## Layout

### Header (Storefront)

```
+------------------------------------------------------------------+
|  [VINILO] Ruby On Records    INICIO  CATALOGO  NUEVOS  USADOS    |
|                                            [Buscar] [INGRESAR]   |
+==================================================================+
   ^ Vinyl Black bg            ^ Cream text        ^ Mustard accents
   ^ 4px mustard bottom border
```

### Header (Admin/Backstore)

```
+------------------------------------------------------------------+
|  [VINILO] Backstore    DASHBOARD  DISCOS  VENTAS  CLIENTES  ...  |
|                                                    [Usuario v]   |
+==================================================================+
   ^ Burgundy bg (diferencia del storefront)
```

### Footer

```
+------------------------------------------------------------------+
|  [VINILO] Ruby On Records     ENLACES          CONTACTO          |
|                               - Catalogo       Av. Corrientes... |
|  Descripcion de la           - Nuevos          Tel: ...          |
|  tienda...                   - Usados          Email: ...        |
|------------------------------------------------------------------|
|          (c) 2026 Ruby On Records - Hecho con Ruby on Rails      |
+------------------------------------------------------------------+
   ^ Vinyl Black bg, Mustard accents, 4px mustard top border
```

---

## Paginas Principales

### Home (Storefront)

1. **Hero Section**
   - Fondo: Vinyl Black con patron diagonal sutil
   - Titulo grande con "Spin" en Mustard
   - Vinilo animado girando
   - Dos CTAs: Primary y Secondary
   - Wave divider hacia cream

2. **Nuevos Ingresos**
   - Grid de 4 columnas (responsive)
   - Cards de productos

3. **Categorias**
   - Divider con texto "VINYL"
   - 3 cards: Vinilos, CDs, Usados
   - Iconos animados en hover

4. **Newsletter CTA**
   - Fondo Vinyl Black
   - Borde Mustard grueso
   - Input + boton

### Catalogo

- Filtros laterales en cards
- Grid de productos
- Paginacion estilo retro

### Detalle de Producto

- Vinilo grande animado
- Info del album
- Precio destacado en Mustard
- Boton agregar prominente

### Login

```
+----------------------------------+----------------------------------+
|                                  |                                  |
|       Panel decorativo           |         Formulario               |
|       con vinilo y               |                                  |
|       branding                   |         Email: [________]        |
|                                  |         Pass:  [________]        |
|       "Bienvenido                |                                  |
|        de vuelta"                |         [INGRESAR]               |
|                                  |                                  |
+----------------------------------+----------------------------------+
        ^ Vinyl Black                      ^ Paper/Cream
```

### Dashboard Admin

- Cards con estadisticas
- Iconos en colores de acento
- Tabla de ultimos items

---

## Prompt para Generar Mockups con IA

### Prompt General

Create a mockup for a vintage vinyl record store web application called "Ruby On Records".

Style guidelines:
- Retro/vintage aesthetic inspired by 1970s-80s record shops
- Color palette: Black (#1a1a1a), Cream (#f5f0e6), Mustard/Gold (#d4a039), Rust (#c45c3e), Teal (#2a9d8f)
- Typography: Elegant serif for headings (like Playfair Display), monospace for body text (like Space Mono)
- UI elements have hard shadows offset to bottom-right (no blur), 2px solid black borders
- Buttons are uppercase with letter-spacing
- Include vinyl record illustrations with grooves pattern and colored label in center
- Warm, nostalgic feeling but with modern usability

The interface should feel like walking into a cozy record store with wooden shelves and handwritten price tags, but translated into a digital experience.

### Prompt para Home Page

Design a homepage for "Ruby On Records" vinyl store website.

Include:
1. Header: Black background, gold "Ruby On Records" logo with spinning vinyl icon, navigation links in cream color
2. Hero section: Large heading "Spin Your Story" with "Spin" in gold, animated vinyl record, two CTA buttons (gold primary, cream secondary), diagonal stripe pattern in background
3. Product grid: 4 cards showing album covers with vinyl peek effect, artist name, price in gold
4. Category section: 3 cards for "Vinilos", "CDs", "Usados" with vinyl/CD icons
5. Newsletter: Black section with gold border, email input field
6. Footer: Black with gold accents, three columns

Style: Retro vintage with hard shadow buttons, serif headings, monospace body text. Colors: black, cream, gold/mustard accents.

### Prompt para Pagina de Producto

Design a product detail page for a vinyl record on "Ruby On Records" website.

Include:
1. Large vinyl record image (black disc with gold center label, visible grooves)
2. Album cover partially visible behind the vinyl
3. Product info: Album title (large serif font), Artist name, Year, Genre badge
4. Price prominently displayed in gold/mustard color
5. "Add to cart" button with hard shadow effect
6. Track listing in a cream-colored card
7. Related products section at bottom

Style: Vintage record store aesthetic, warm cream background, black and gold accents, retro typography with serif headings and monospace details.

### Prompt para Dashboard Admin

Design an admin dashboard for "Ruby On Records" vinyl store management system.

Include:
1. Header: Burgundy/wine color background with store logo
2. Sidebar or top navigation: Dashboard, Disks, Sales, Clients, Genres, Users
3. Stats cards: Total disks, Total sales, Total clients, Total users - each with an icon and number
4. Recent activity table with vintage styling (black header, cream rows)
5. Quick action buttons with hard shadows