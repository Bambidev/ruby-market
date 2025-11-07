class Item < ApplicationRecord

  #:amount ::= Cantidad de un mismo producto comprado en una Venta
  validates :amount, presence: true, :numericality => {
    :only_integer => true,
    :greater_than_or_equal_to => 0
  }
end
