class CreateDiscos < ActiveRecord::Migration[8.1]
  def change
    create_table :discos do |t|
      t.string :titulo
      t.integer :año
      t.string :descripcion
      t.string :artista
      t.float :precio_unitario
      t.integer :stock
      t.string :genero
      t.string :tipo
      t.datetime :fecha_de_baja

      t.timestamps
    end
  end
end
