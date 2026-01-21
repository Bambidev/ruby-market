# Guía de Instalación - Ruby On Records

## Requisitos Previos

- Ruby 3.4.5
- Rails 8.1.1
- SQLite3

## Instalación

### Clonar el repositorio

```bash
git clone <URL_DEL_REPOSITORIO>
cd ruby-on-records
```

### Instalar dependencias

```bash
bundle install
```

### Configurar base de datos

```bash
bin/rails db:setup
```

### Iniciar servidor de desarrollo

```bash
bin/dev
```

Abrir http://localhost:3000

## Usuarios de Prueba

| Rol      | Email                  | Password   |
|----------|------------------------|------------|
| Admin    | admin@rubyonrecords.com| admin123   |
| Gerente  | gerente@rubyonrecords.com| gerente123|
| Empleado | empleado@rubyonrecords.com| empleado123|

## Comandos Útiles

### Desarrollo

```bash
bin/dev                    # Iniciar servidor + Tailwind watch
bin/rails console          # Consola interactiva
bin/rails routes           # Ver todas las rutas
```

### Base de datos

```bash
bin/rails db:reset         # Resetear BD completa
bin/rails db:seed          # Cargar datos de prueba
```

### Tests

```bash
bin/rails test             # Ejecutar tests
bin/rails test:system      # Tests de sistema
```

### Calidad de código

```bash
bundle exec rubocop        # Linter de Ruby
bundle exec brakeman       # Análisis de seguridad
```

## Posibles Problemas

- **Error "cannot load such file -- bcrypt"**: Ejecuta `bundle install` para instalar todas las dependencias, incluyendo bcrypt para el hashing de contraseñas.

- **Base de datos vacía**: Si al intentar iniciar sesión no hay usuarios, ejecuta `bin/rails db:seed` para crear los usuarios de prueba. Esto es necesario si `bin/rails db:setup` no ejecutó las seeds correctamente.