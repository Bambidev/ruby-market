class CambiarDescripcionDeStringAText2 < ActiveRecord::Migration[8.1]
  def change
    change_column :discos, :descripcion, :text
  end
end
