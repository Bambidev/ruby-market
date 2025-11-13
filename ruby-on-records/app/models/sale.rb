class Sale < ApplicationRecord
  # === Relaciones === #

  # Una Venta es ejecutada por un Usuario Vendedor
  belongs_to :user
  # Una Venta es comprada por un Cliente
  belongs_to :client

  # The belongs_to association says that this model's table contains a column which represents a reference to another table.
  # This can be used to set up one-to-one or one-to-many relations, depending on the setup.
  # When used alone, belongs_to produces a one-directional one-to-one relationship.
  # Therefore each book in the above example "knows" its author, but the authors don't know about their books.
  # https://guides.rubyonrails.org/association_basics.html#belongs-to

  # Una Venta contiene varios Items
  has_many :items

  # A has_many association (...) indicates a one-to-many relationship with another model.
  # You'll often find this association on the "other side" of a belongs_to association.
  # This association indicates that each instance of the model has zero or more instances of another model.
  # https://guides.rubyonrails.org/association_basics.html#has-many

  # === Validadores === #

  # :cancelled ::= Venta cancelada (True) o no (False)
  validates :cancelled, presence: true

  # :total ::= Total a pagar de una Venta
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
