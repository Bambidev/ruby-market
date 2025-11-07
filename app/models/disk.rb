class Disk < ApplicationRecord
  #:title ::= Titulo del disco
  validates :titulo, presence: true

  #:artist ::= Artista o banda
  validates :artist, presence: true

  #:year ::= Año de lanzamiento
  validates :year, presence: true, :numericality => {
    :only_integer => true,
    :greater_than_or_equal_to => 1900,
    :less_than_or_equal_to => Date.current.year
  }

  #:description ::= Texto descriptivo
  validates :description, presence: true

  #:price ::= Precio unitario
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }

  #:stock ::= Cantidad disponible
  validates :stock, presence: true, :numericality => {
    :only_integer => true,
    :greater_than_or_equal_to => 0
  }

  #:format ::= CD o Vinilo
  validates :format, presence: true, :inclusion => { :in => %w(CD Vinilo),
      :message => "No trabajamos con formato '%{value}'" }

  #:state ::= Nuevo o usado
  validates :state, presence: true, :inclusion => { :in => %w(Nuevo Usado),
      :message => "No trabajamos discos en estado '%{value}'" }

end
