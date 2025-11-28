class User < ApplicationRecord
  # === Autenticación === #
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
      message: "Sólo se permiten ingresar letras para el nombre" }

  # :email ::= Correo electrónico de un usuario
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
      message: "Formato de correo electrónico incorrecto" }

  # === Métodos de Autorización === #

  def admin?
    role == "admin"
  end

  def gerente?
    role == "gerente"
  end

  def empleado
    role == "empleado"
  end

  def gerente_o_superior?
    admin? || gerente?
  end

  def can_manage_users?
    admin?
  end

  def can_manage_sales?
    gerente_o_superior?
  end

  def can_view_reports?
    gerente_o_superior?
  end
end
