module DisksHelper
  # Badge de disponibilidad del disco
  # @param disk [Disk] disco
  # @return [String] HTML del badge
  def disk_availability_badge(disk)
    if disk.stock > 10
      content_tag :span, "En Stock (#{disk.stock})", class: "inline-block px-3 py-1 text-xs font-bold rounded-full bg-green-500 text-white"
    elsif disk.stock > 0
      content_tag :span, "Pocas unidades (#{disk.stock})", class: "inline-block px-3 py-1 text-xs font-bold rounded-full bg-yellow-500 text-white"
    else
      content_tag :span, "Agotado", class: "inline-block px-3 py-1 text-xs font-bold rounded-full bg-red-500 text-white"
    end
  end

  # Ícono del formato del disco
  # @param format [String] formato (CD o Vinilo)
  # @return [String] emoji del formato
  def disk_format_icon(format)
    case format
    when "CD" then "💿"
    when "Vinilo" then "📀"
    else "🎵"
    end
  end

  # Badge del estado del disco
  # @param state [String] estado (Nuevo o Usado)
  # @return [String] HTML del badge
  def disk_state_badge(state)
    if state == "Nuevo"
      content_tag :span, "Nuevo", class: "inline-block px-2 py-1 text-xs font-bold rounded bg-blue-100 text-blue-800"
    else
      content_tag :span, "Usado", class: "inline-block px-2 py-1 text-xs font-bold rounded bg-gray-100 text-gray-800"
    end
  end

  # Precio del disco formateado
  # @param disk [Disk] disco
  # @return [String] precio formateado
  def disk_price_formatted(disk)
    format_currency(disk.price)
  end
end

