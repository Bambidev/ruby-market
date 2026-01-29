class FixSalesAndItems < ActiveRecord::Migration[8.1]
  def change
    # Fix Sales Table
    add_reference :sales, :client, null: false, foreign_key: true
    add_reference :sales, :user, null: false, foreign_key: true
    change_column_default :sales, :cancelled, from: nil, to: false

    # Fix Items Table
    add_reference :items, :sale, null: false, foreign_key: true
    add_reference :items, :disk, null: false, foreign_key: true
    add_column :items, :price, :float
    rename_column :items, :amount, :quantity
  end
end
