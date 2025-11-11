class Genre < ApplicationRecord

  # === Validadores === #

  #:genre ::= nombre del género musical
  validates :genre, presence: true

  # === Relaciones === #

  # Un Género puede pertenecer a varios Discos
  has_and_belongs_to_many :disks

end
