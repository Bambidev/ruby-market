# frozen_string_literal: true

module Sales
  # Service Object para cancelar ventas
  # Maneja la lógica de cancelación y devolución de stock
  class Canceller
    attr_reader :sale, :errors

    def initialize(sale)
      @sale = sale
      @errors = []
    end

    def call
      return failure("La venta ya está cancelada") if @sale.cancelled?

      ActiveRecord::Base.transaction do
        @sale.update!(cancelled: true)
        restore_stock
      end

      success
    rescue ActiveRecord::RecordInvalid => e
      @errors << e.message
      failure
    rescue StandardError => e
      @errors << "Error inesperado: #{e.message}"
      failure
    end

    def success?
      @success == true
    end

    private

    def restore_stock
      @sale.items.each do |item|
        # Usar increment! es más eficiente y atómico
        item.disk.increment!(:stock, item.quantity)
      end
    end

    def success
      @success = true
      self
    end

    def failure(message = nil)
      @errors << message if message
      @success = false
      self
    end
  end
end
