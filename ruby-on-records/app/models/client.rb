class Client < ApplicationRecord
  # === Relaciones === #

  # Un Cliente puede tener varias Ventas a su nombre
  has_many :sales

  # === Validadores === #

  # :name ::= Nombre del cliente
  validates :name, presence: true

  # :dni ::= Numero de DNI del cliente
  validates :dni, presence: true, numericality: { only_integer: true }
end
