class User < ApplicationRecord
  # === Validadores === #

  # :full_name ::= Nombre completo de un usuario
  validates :full_name, presence: true, format: { with: /\A[a-zA-Z]+\z/,
      message: "Only letters allowed" }

  # :email ::= Correo electrónico de un usuario
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
      message: "Not an email" }

  # :password_digest ::= Contraseña hasheada
  validates :password, presence: true

  # === Relaciones === #

  # Un Usuario Vendedor puede haberse encargado de varias Ventas
  has_many :sales
end
