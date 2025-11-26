class RemoveTypeFromDisks < ActiveRecord::Migration[8.1]
  def change
    remove_column :disks, :type, :string
  end
end
