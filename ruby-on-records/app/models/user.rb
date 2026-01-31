class User < ApplicationRecord
  # === Autenticacion === #
  has_secure_password

  # === Roles === #
  # 0 = empleado (por defecto), 1 = gerente, 2 = admin
  enum :role, { empleado: 0, gerente: 1, admin: 2 }, default: :empleado

  # === Relaciones === #

  # Un Usuario Vendedor puede haberse encargado de varias Ventas
  has_many :sales

  # === Validadores === #

  # :full_name ::= Nombre completo de un usuario
  validates :full_name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/,
      message: "Solo se permiten ingresar letras para el nombre" }

  # :email ::= Correo electronico de un usuario
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
      message: "Formato de correo electronico incorrecto" }
end
