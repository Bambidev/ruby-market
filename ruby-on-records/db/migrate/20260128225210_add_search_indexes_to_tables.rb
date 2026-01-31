class AddSearchIndexesToTables < ActiveRecord::Migration[8.1]
  def change
    # Índices para búsquedas en Disks
    add_index :disks, :title
    add_index :disks, :artist
    add_index :disks, :state
    add_index :disks, :format
    add_index :disks, :price
    
    # Índices para búsquedas en Clients
    add_index :clients, :name
    add_index :clients, :email
    
    # Índices para ordenamiento y filtrado de Sales
    add_index :sales, :created_at
    add_index :sales, :cancelled
    add_index :sales, [:cancelled, :created_at]
  end
end
