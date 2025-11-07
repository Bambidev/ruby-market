class Client < ApplicationRecord

  #:name ::= Nombre del cliente
  validates :name, presence: true

  #:dni ::= Numero de DNI del cliente
  validates :dni, presence: true, :numericality => { :only_integer => true }
end
