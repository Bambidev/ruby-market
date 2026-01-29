# 🎨 Sistema de Diseño - Ruby On Records

<div align="center">

*Guía visual y de componentes para mantener consistencia en toda la aplicación*

<img src="https://media.giphy.com/media/3o7TKSjRrfIPjeiVyM/giphy.gif" width="200" alt="Design">

</div>

---

## 📑 Índice

1. [Filosofía de Diseño](#-filosofía-de-diseño)
2. [Paleta de Colores](#-paleta-de-colores)
3. [Tipografía](#-tipografía)
4. [Componentes](#-componentes)
5. [Iconografía](#-iconografía)
6. [Animaciones](#-animaciones)
7. [Layouts](#-layouts)

---

## 🎯 Filosofía de Diseño

### Inspiración

Ruby On Records se inspira en la **estética de las disquerías de los años 70s y 80s**:

| Elemento | Inspiración |
|----------|-------------|
| 🎨 Colores | Tonos cálidos, mostaza, óxido, crema |
| 📝 Tipografía | Display serif + Monospace |
| 🔲 Bordes | Gruesos, sólidos, sin redondear |
| 💫 Sombras | Duras, offset, estilo "drop shadow" |
| 💿 Elementos | Vinilos, casetes, portadas de discos |

### Principios

1. **Nostalgia funcional** - Retro pero usable
2. **Contraste claro** - Fácil lectura
3. **Consistencia** - Mismos patrones en toda la app
4. **Responsive** - Mobile-first design

---

## 🎨 Paleta de Colores

### Colores Principales

<table>
<tr>
<td align="center">

**Vinyl Black**
<br>
`#1a1a1a`
<br>
<img src="https://via.placeholder.com/80/1a1a1a/1a1a1a" width="80" height="40">
<br>
*Fondos, headers, texto*

</td>
<td align="center">

**Cream**
<br>
`#f5f0e6`
<br>
<img src="https://via.placeholder.com/80/f5f0e6/f5f0e6" width="80" height="40">
<br>
*Fondos claros*

</td>
<td align="center">

**Mustard**
<br>
`#d4a039`
<br>
<img src="https://via.placeholder.com/80/d4a039/d4a039" width="80" height="40">
<br>
*Acentos, CTAs*

</td>
</tr>
</table>

### Colores Secundarios

<table>
<tr>
<td align="center">

**Rust**
<br>
`#a65d57`
<br>
<img src="https://via.placeholder.com/60/a65d57/a65d57" width="60" height="30">
<br>
*Errores, alertas*

</td>
<td align="center">

**Teal**
<br>
`#4a8f8f`
<br>
<img src="https://via.placeholder.com/60/4a8f8f/4a8f8f" width="60" height="30">
<br>
*Éxito, "Nuevo"*

</td>
<td align="center">

**Sepia**
<br>
`#8b7355`
<br>
<img src="https://via.placeholder.com/60/8b7355/8b7355" width="60" height="30">
<br>
*Texto secundario*

</td>
<td align="center">

**Burgundy**
<br>
`#722f37`
<br>
<img src="https://via.placeholder.com/60/722f37/722f37" width="60" height="30">
<br>
*Header admin*

</td>
</tr>
</table>

### Variables CSS

```css
@theme {
  /* Primarios */
  --color-vinyl-black: #1a1a1a;
  --color-vinyl-dark: #2d2d2d;
  --color-vinyl-groove: #404040;
  --color-cream: #f5f0e6;
  --color-cream-dark: #e8e0d0;
  --color-paper: #faf8f3;
  
  /* Acentos */
  --color-mustard: #d4a039;
  --color-mustard-dark: #b8862d;
  --color-rust: #a65d57;
  --color-teal: #4a8f8f;
  --color-teal-dark: #3d7575;
  
  /* UI */
  --color-sepia: #8b7355;
  --color-burgundy: #722f37;
}
```

---

## 📝 Tipografía

### Fuentes

| Fuente | Uso | Peso |
|:------:|-----|------|
| **Playfair Display** | Títulos, headings | 400, 700, 900 |
| **Space Mono** | UI, etiquetas, código | 400, 700 |

### Import

```html
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=Space+Mono:wght@400;700" rel="stylesheet">
```

### Clases

```css
.font-display { font-family: 'Playfair Display', serif; }
.font-mono { font-family: 'Space Mono', monospace; }
```

### Escala

| Clase | Tamaño | Uso |
|-------|--------|-----|
| `text-5xl` | 3rem | Hero titles |
| `text-4xl` | 2.25rem | Page titles |
| `text-2xl` | 1.5rem | Section titles |
| `text-xl` | 1.25rem | Card titles |
| `text-base` | 1rem | Body text |
| `text-sm` | 0.875rem | Labels, captions |
| `text-xs` | 0.75rem | Badges, small labels |

---

## 🧩 Componentes

### Botones

#### Primary Button
```html
<button class="btn-primary">Guardar</button>
```
```css
.btn-primary {
  @apply px-6 py-3 bg-mustard text-vinyl-black font-bold 
         uppercase tracking-wider border-2 border-vinyl-black 
         shadow-retro hover:shadow-retro-lg hover:-translate-y-0.5 
         transition-all cursor-pointer;
}
```

#### Secondary Button
```html
<button class="btn-secondary">Cancelar</button>
```
```css
.btn-secondary {
  @apply px-6 py-3 bg-cream text-vinyl-black font-bold 
         uppercase tracking-wider border-2 border-vinyl-black 
         hover:bg-cream-dark transition-colors;
}
```

#### Danger Button
```html
<button class="btn-danger">Eliminar</button>
```
```css
.btn-danger {
  @apply px-6 py-3 bg-rust text-cream font-bold 
         uppercase tracking-wider border-2 border-vinyl-black 
         hover:bg-rust/80 transition-colors;
}
```

---

### Cards

#### Card Retro
```html
<div class="card-retro p-6">
  <h3>Título</h3>
  <p>Contenido</p>
</div>
```
```css
.card-retro {
  @apply bg-paper border-2 border-vinyl-black shadow-retro;
}
```

#### Disk Card
```erb
<%= render 'shared/disk_card', disk: @disk %>
```
- Portada con efecto hover
- Badge de formato (CD/Vinilo)
- Badge de estado (Nuevo/Usado)
- Título y artista truncados
- Precio

---

### Formularios

#### Input
```html
<input type="text" class="input-retro" placeholder="Buscar...">
```
```css
.input-retro {
  @apply w-full px-4 py-3 bg-cream border-2 border-vinyl-black 
         font-mono focus:outline-none focus:border-mustard 
         focus:ring-2 focus:ring-mustard/20;
}
```

#### Select
```html
<select class="select-retro">
  <option>Opción 1</option>
</select>
```
```css
.select-retro {
  @apply w-full px-4 py-3 bg-cream border-2 border-vinyl-black 
         font-mono focus:outline-none focus:border-mustard 
         appearance-none cursor-pointer;
}
```

#### Label
```html
<label class="label-retro">Nombre</label>
```
```css
.label-retro {
  @apply block font-mono text-xs uppercase tracking-wider 
         text-sepia mb-2;
}
```

---

### Tablas

```html
<table class="table-retro">
  <thead>
    <tr>
      <th>Columna</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Dato</td>
    </tr>
  </tbody>
</table>
```
```css
.table-retro {
  @apply w-full;
}
.table-retro th {
  @apply bg-vinyl-black text-cream text-left px-4 py-3 
         font-mono text-xs uppercase tracking-wider;
}
.table-retro td {
  @apply px-4 py-3 border-b border-vinyl-groove/20;
}
.table-retro tr:hover {
  @apply bg-cream-dark/50;
}
```

---

### Badges

#### Badge Retro
```html
<span class="badge-retro bg-mustard text-vinyl-black">Vinilo</span>
<span class="badge-retro bg-teal text-cream">Nuevo</span>
<span class="badge-retro bg-sepia text-cream">Usado</span>
```
```css
.badge-retro {
  @apply inline-block px-3 py-1 text-xs font-bold 
         uppercase tracking-wider border border-current;
}
```

#### Genre Bubble
```html
<span class="genre-bubble">Rock</span>
```
```css
.genre-bubble {
  @apply inline-block px-3 py-1 text-xs font-medium rounded-full 
         bg-vinyl-groove/20 text-vinyl-dark 
         hover:bg-mustard/30 hover:text-vinyl-black 
         transition-colors cursor-pointer;
}
```

---

### Sombras

```css
--shadow-retro: 4px 4px 0 var(--color-vinyl-black);
--shadow-retro-lg: 6px 6px 0 var(--color-vinyl-black);
```

| Clase | Uso |
|-------|-----|
| `shadow-retro` | Cards, botones |
| `shadow-retro-lg` | Hover states |

---

## 🎵 Iconografía

### Vinyl Record

```css
.vinyl-record {
  @apply rounded-full;
  background: 
    radial-gradient(circle at center, 
      var(--color-mustard) 15%, 
      var(--color-vinyl-black) 15%, 
      var(--color-vinyl-black) 30%, 
      var(--color-vinyl-dark) 30%);
  background-size: 100% 100%;
}
```

### CD Record

```css
.cd-record {
  @apply rounded-full;
  background: 
    radial-gradient(circle at center, 
      transparent 15%, 
      #c0c0c0 15%, 
      #e8e8e8 50%, 
      #c0c0c0 100%);
}
```

---

## 💫 Animaciones

### Spin (Vinyl)

```css
@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.vinyl-spin-hover:hover {
  animation: spin 2s linear infinite;
}
```

### Transition Classes

```css
.transition-all {
  transition: all 0.2s ease;
}

.transition-colors {
  transition: color, background-color 0.2s ease;
}

.hover:-translate-y-0.5:hover {
  transform: translateY(-2px);
}
```

---

## 📐 Layouts

### Storefront Layout

```
┌─────────────────────────────────────────────┐
│  HEADER (bg-vinyl-black)                    │
│  Logo | Nav Links | Login                   │
├─────────────────────────────────────────────┤
│                                             │
│  MAIN (bg-cream, max-w-7xl, mx-auto, px-4)  │
│                                             │
│  <%= yield %>                               │
│                                             │
├─────────────────────────────────────────────┤
│  FOOTER (bg-vinyl-black)                    │
│  © Ruby On Records                          │
└─────────────────────────────────────────────┘
```

### Admin Layout

```
┌─────────────────────────────────────────────┐
│  HEADER (bg-burgundy)                       │
│  🎵 Backstore | Nav | User Menu             │
├─────────────────────────────────────────────┤
│                                             │
│  MAIN (bg-cream-dark, max-w-7xl, p-8)       │
│                                             │
│  Flash Messages                             │
│  <%= yield %>                               │
│                                             │
└─────────────────────────────────────────────┘
```

### Grid System

```html
<!-- 4 columns on desktop, 2 on tablet, 1 on mobile -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
  <!-- Cards -->
</div>
```

---

## 📱 Responsive Breakpoints

| Breakpoint | Tamaño | Uso |
|:----------:|:------:|-----|
| `sm` | 640px | Tablet pequeña |
| `md` | 768px | Tablet |
| `lg` | 1024px | Desktop |
| `xl` | 1280px | Desktop grande |

---

<div align="center">

## 🎨 Quick Reference

| Elemento | Clase |
|----------|-------|
| Botón principal | `btn-primary` |
| Botón secundario | `btn-secondary` |
| Card | `card-retro p-6` |
| Input | `input-retro` |
| Select | `select-retro` |
| Badge | `badge-retro` |
| Tabla | `table-retro` |
| Label | `label-retro` |

---

*Sistema de diseño v1.0 - Ruby On Records*

</div>