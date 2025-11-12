class Genre < ApplicationRecord

  # === Validadores === #

  #:name ::= nombre del género musical
  validates :name, presence: true

  # === Relaciones === #

  # Un Género puede pertenecer a varios Discos
  has_and_belongs_to_many :disks

end
