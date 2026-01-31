class Sale < ApplicationRecord
  # === Relaciones === #
  belongs_to :user
  belongs_to :client
  has_many :items, dependent: :destroy
  
  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :client, reject_if: :all_blank

  # === Validadores === #
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :client, presence: true
  validates :user, presence: true

  # === Scopes === #
  scope :active, -> { where(cancelled: false) }
  scope :cancelled, -> { where(cancelled: true) }
  scope :recent, -> { order(created_at: :desc) }

  # === Métodos de Instancia === #
  
  # Cancela la venta usando el Service Object
  # @return [Boolean] true si se canceló exitosamente
  def cancel!
    result = Sales::Canceller.new(self).call
    result.success?
  end

  # Calcula el total de la venta
  # @return [Float] total calculado
  def calculated_total
    items.sum { |item| item.price * item.quantity }
  end
end

