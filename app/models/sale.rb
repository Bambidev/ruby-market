class Sale < ApplicationRecord
  #:cancelled ::= Venta cancelada (True) o no (False)
  validates :cancelled, presence: true

  #:artist ::= Artista o banda
  validates :artist, presence: true
end
