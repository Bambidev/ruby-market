class Item < ApplicationRecord
  # === Validadores === #

  # :amount ::= Cantidad de un mismo producto comprado en una Venta
  validates :amount, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  # === Relaciones === #

  # Un Item pertenece a una Venta
  belongs_to :sale
  # Un Item es un Disco
  belongs_to :disc
end
