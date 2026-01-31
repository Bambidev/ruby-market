class Disk < ApplicationRecord
  include Searchable

  # === Scopes === #
  scope :by_state, ->(filter) {
    case filter
    when "new" then where(state: "Nuevo")
    when "used" then where(state: "Usado")
    else all
    end
  }

  scope :by_format, ->(format) {
    where(format: format) if format.present?
  }

  scope :search, ->(query) {
    search_in_fields(query, %w[title artist description])
  }

  scope :in_stock, -> { where("stock > 0") }
  scope :out_of_stock, -> { where(stock: 0) }
  
  # Soft Delete Scope
  default_scope { where(deleted_at: nil) }

  def soft_delete
    update(deleted_at: Time.current)
  end

  def recover
    update(deleted_at: nil)
  end


  # === Relaciones === #

  # Un mismo Disco puede estar presente en varios Items de varias Ventas
  has_many :items

  # Un Disco puede pertenecer a varios Géneros
  has_and_belongs_to_many :genres

  # Un Disco puede tener varias fotos y una portada
  has_many_attached :photos
  has_one_attached :cover
  has_one_attached :preview

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
