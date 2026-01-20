class Disk < ApplicationRecord
  # === Scopes === #
  scope :by_state, ->(filter) {
    case filter
    when "new" then where(state: "Nuevo")
    when "used" then where(state: "Usado")
    else all
    end
  }

  # === Relaciones === #

  # Un mismo Disco puede estar presente en varios Items de varias Ventas
  has_many :items

  # Un Disco puede pertenecer a varios Géneros
  has_and_belongs_to_many :genres

  # A has_and_belongs_to_many association creates a direct many-to-many relationship with another model, with no intervening model.
  # This association indicates that each instance of the declaring model refers to zero or more instances of another model.
  # You'd use has_and_belongs_to_many when:
  # * The association is simple and does not require additional attributes or behaviors on the join table.
  # * You do not need validations, callbacks, or extra methods on the join table.
  # https://guides.rubyonrails.org/association_basics.html#has-and-belongs-to-many

  # === Validadores === #

  # :title ::= Titulo del disco
  validates :title, presence: true

  # :artist ::= Artista o banda
  validates :artist, presence: true

  # :year ::= Año de lanzamiento
  validates :year, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1870,
    less_than_or_equal_to: Date.current.year
  }

  # :description ::= Texto descriptivo
  validates :description, presence: true, length: { minimum: 10 }

  # :price ::= Precio unitario
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # :stock ::= Cantidad disponible
  validates :stock, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  # :format ::= CD o Vinilo
  validates :format, presence: true, inclusion: { in: %w[CD Vinilo],
    message: "No trabajamos con formato '%{value}'" }

  # :state ::= Nuevo o usado
  validates :state, presence: true, inclusion: { in: %w[Nuevo Usado],
    message: "No trabajamos discos en estado '%{value}'" }
end
