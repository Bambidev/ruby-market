# frozen_string_literal: true

module Sales
  # Service Object para crear ventas
  # Maneja la lógica compleja de validación de stock, cálculo de totales y decrementación
  class Creator
    attr_reader :sale, :errors

    def initialize(sale_params, user)
      @sale_params = sale_params
      @user = user
      @errors = []
    end

    def call
      build_sale
      return failure unless valid?

      ActiveRecord::Base.transaction do
        calculate_total
        @sale.save!
        decrement_stock
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

    def build_sale
      @sale = Sale.new(@sale_params)
      @sale.user = @user
    end

    def valid?
      validate_has_items
      validate_items_have_disk
      validate_stock_availability
      @errors.empty?
    end

    def validate_has_items
      valid_items = @sale.items.reject { |i| i.disk_id.blank? }
      @errors << "Debe agregar al menos un producto con disco seleccionado" if valid_items.empty?
    end

    def validate_items_have_disk
      @sale.items.each_with_index do |item, index|
        next if item.marked_for_destruction?
        next if item.disk_id.present?
        
        @errors << "El producto ##{index + 1} no tiene disco seleccionado"
      end
    end

    def validate_stock_availability
      @sale.items.each do |item|
        next if item.marked_for_destruction? || item.disk.nil?

        if item.disk.stock < item.quantity
          @errors << "No hay suficiente stock para #{item.disk.title} (Solicitado: #{item.quantity}, Disponible: #{item.disk.stock})"
        end
      end
    end

    def calculate_total
      @sale.total = @sale.items.reject(&:marked_for_destruction?).sum do |item|
        (item.price.to_f * item.quantity.to_i)
      end
    end

    def decrement_stock
      @sale.items.each do |item|
        next if item.disk.nil? || item.marked_for_destruction?
        # Usar update_counters es más eficiente y atómico
        Disk.update_counters(item.disk_id, stock: -item.quantity)
      end
    end

    def success
      @success = true
      self
    end

    def failure
      @success = false
      self
    end
  end
end
