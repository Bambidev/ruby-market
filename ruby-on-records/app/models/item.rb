class Item < ApplicationRecord
  # === Relaciones === #
  belongs_to :sale
  belongs_to :disk

  attr_accessor :item_query

  # === Validadores === #
  validates :quantity, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  # Delegate useful methods
  delegate :title, to: :disk, prefix: true
end
