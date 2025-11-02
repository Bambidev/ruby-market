# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Disco.destroy_all

# Sugerencia... cada disco podría tener varios géneros, para así crear las relaciones necesarias para el algoritmo de descubrimiento.
# Ejemplo: Diamonds and Pearls podría ser [R&B, pop soul, funk] en vez de sólo R&B.
# Para evitar usar un array, los géneros podrían ser una entidad (Genero) y tener una relacion (1,n) con Disco.
Disco.create!([{
  titulo: "Diamonds and Pearls",
  año: 1991,
  descripcion: "Este fue el segundo trabajo de Prince en ser lanzado oficialmente junto a The New Power Generation. Diamonds and Pearls presenta una fusión de estilos musicales, desde el funk y el soul hasta el rock y baladas.",
  artista: "The New Power Generation",
  precio_unitario: 20_000,
  stock: 100,
  genero: "R&B",
  tipo: "CD",
  fecha_de_baja: nil
},
{
  titulo: "Yours Truly, Angry Mob",
  año: 2007,
  descripcion: "El lanzamiento de este álbum estuvo precedido por el lanzamiento de Ruby, el primer sencillo del álbum. Al igual que el álbum debut de la banda, Employment, Yours Truly, Angry Mob fue producido, una vez más por Stephen Street, siendo este disco, con respecto a las letras, más oscuro y con más conciencia social que el anterior, con canciones que tratan de temas tales como los crímenes, la violencia y la fama.",
  artista: "Kaiser Chiefs",
  precio_unitario: 15_000,
  stock: 50,
  genero: "Indie Rock",
  tipo: "CD",
  fecha_de_baja: nil
},
{
  titulo: "Wish You Were Here",
  año: 1975,
  descripcion: "Los temas líricos del álbum se refieren a la alienación y la crítica del negocio de la música. La mayor parte del álbum está ocupada por «Shine On You Crazy Diamond», un tributo de nueve partes al miembro fundador Syd Barrett, quien dejó la banda siete años antes debido al deterioro de su salud mental.",
  artista: "Pink Floyd",
  precio_unitario: 50_000,
  stock: 20,
  genero: "Rock progresivo",
  tipo: "Vinilo",
  fecha_de_baja: nil
},
{
  titulo: "Jessico",
  año: 2001,
  descripcion: "Jessico es el sexto álbum de estudio de la banda argentina Babasónicos. El disco significó para la banda la entrada a la lista de los grupos más importantes de la Argentina, en el momento donde había ocurrido una crisis en diciembre de 2001 en el país. Jessico está considerado como el #16 entre los 100 mejores álbumes del rock argentino según la lista de la revista Rolling Stone.",
  artista: "Babasónicos",
  precio_unitario: 20_000,
  stock: 200,
  genero: "Rock argentino",
  tipo: "CD",
  fecha_de_baja: nil
},
{
  titulo: "Alma de Diamante",
  año: 1980,
  descripcion: "El disco está integrado por siete temas compuestos por Spinetta bajo la inspiración de sus lecturas de cuatro libros relacionados con el chamanismo, del antropólogo Carlos Castaneda: Las enseñanzas de Don Juan, Una realidad aparte, Viaje a Ixtlán y Relatos de poder.",
  artista: "Spinetta Jade",
  precio_unitario: 55_000,
  stock: 10,
  genero: "Rock argentino",
  tipo: "Vinilo",
  fecha_de_baja: nil
}])
p "#{Disco.count} discos creados!"
p "#{Disco.all}"
