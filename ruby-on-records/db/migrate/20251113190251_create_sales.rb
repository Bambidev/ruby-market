class CreateSales < ActiveRecord::Migration[8.1]
  def change
    create_table :sales do |t|
      t.boolean :cancelled
      t.float :total

      t.timestamps
    end
  end
end
