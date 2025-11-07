class CreateDisks < ActiveRecord::Migration[8.1]
  def change
    create_table :disks do |t|
      t.string :title
      t.string :artist
      t.integer :year
      t.text :description
      t.float :price
      t.integer :stock
      t.string :format
      t.string :state

      t.timestamps
    end
  end
end
