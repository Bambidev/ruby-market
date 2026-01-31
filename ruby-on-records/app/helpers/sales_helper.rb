module SalesHelper
  # Badge de estado de la venta
  # @param sale [Sale] venta
  # @return [String] HTML del badge
  def sale_status_badge(sale)
    if sale.cancelled?
      content_tag :span, "Cancelada", class: "inline-block px-3 py-1 text-xs font-bold rounded-full bg-red-500 text-white"
    else
      content_tag :span, "Activa", class: "inline-block px-3 py-1 text-xs font-bold rounded-full bg-green-500 text-white"
    end
  end

  # Total de la venta formateado
  # @param sale [Sale] venta
  # @return [String] total formateado
  def sale_total_with_currency(sale)
    format_currency(sale.total)
  end

  # Cantidad de items en la venta
  # @param sale [Sale] venta
  # @return [String] texto descriptivo
  def sale_items_count(sale)
    count = sale.items.sum(:quantity)
    pluralize(count, "artículo", "artículos")
  end

  # Calcula el total del formulario de venta
  # @param sale [Sale] venta (puede tener items no guardados)
  # @return [String] total formateado
  def calculate_form_total(sale)
    return "0.00" if sale.nil? || sale.items.empty?

    total = sale.items.reject(&:marked_for_destruction?).sum do |item|
      quantity = item.quantity.to_i
      price = item.price.to_f
      
      # Si no hay precio pero hay disco, usar precio del disco
      if price.zero? && item.disk_id.present?
        disk = Disk.find_by(id: item.disk_id)
        price = disk&.price.to_f
      end
      
      quantity * price
    end
    
    format("%.2f", total)
  end
end

