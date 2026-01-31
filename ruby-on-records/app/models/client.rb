class Client < ApplicationRecord
  include Searchable

  # === Relaciones === #
  has_many :sales, dependent: :restrict_with_error

  # === Validaciones === #
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :dni, presence: true, 
                  numericality: { only_integer: true },
                  uniqueness: { message: "ya está registrado" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }
  validates :phone, format: { with: /\A[\d\s\-\+\(\)]+\z/, allow_blank: true }

  # === Callbacks === #
  before_validation :normalize_dni

  # === Scopes === #
  scope :search, ->(query) {
    return all if query.blank?
    search_in_fields(query, %w[name email phone]) || 
      where("dni::text LIKE ?", "%#{sanitize_sql_like(query.to_s.strip)}%")
  }

  scope :recent, -> { order(created_at: :desc) }

  # === Métodos de Instancia === #
  
  # Nombre completo con DNI para display en selects
  def display_name
    "#{name} (DNI: #{dni})"
  end

  # Información completa del cliente
  def full_info
    info = [name, "DNI: #{dni}"]
    info << "Email: #{email}" if email.present?
    info << "Tel: #{phone}" if phone.present?
    info.join(" | ")
  end

  private

  def normalize_dni
    self.dni = dni.to_s.gsub(/\D/, '') if dni.present?
  end
end
