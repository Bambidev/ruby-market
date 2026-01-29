class AddPhoneToClientsAndAddUniqueIndexToDni < ActiveRecord::Migration[8.1]
  def change
    # Agregar campo phone a clients
    add_column :clients, :phone, :string
    
    # Agregar índice único a DNI para prevenir duplicados
    add_index :clients, :dni, unique: true
  end
end
