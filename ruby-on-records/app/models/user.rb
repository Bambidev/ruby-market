class User < ApplicationRecord
  # === Relaciones === #

  # Un Usuario Vendedor puede haberse encargado de varias Ventas
  has_many :sales

  # === Validadores === #

  # :full_name ::= Nombre completo de un usuario
  validates :full_name, presence: true, format: { with: /\A[a-zA-Z]+\z/,
      message: "Sólo se permiten ingresar letras para el nombre" }

  # :email ::= Correo electrónico de un usuario
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
      message: "Formato de correo electrónico incorrecto" }

  # :password_digest ::= Contraseña hasheada
  validates :password, presence: true
end
