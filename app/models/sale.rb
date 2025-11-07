class Sale < ApplicationRecord
  #:cancelled ::= Venta cancelada (True) o no (False)
  validates :cancelled, presence: true

  #:total ::= Total a pagar de una Venta
  validates :total, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end
