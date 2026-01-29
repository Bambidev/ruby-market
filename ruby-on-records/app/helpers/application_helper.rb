module ApplicationHelper
  # Formatea un monto como moneda
  # @param amount [Numeric] monto a formatear
  # @return [String] monto formateado como "$1.234,56"
  def format_currency(amount)
    number_to_currency(amount, unit: "$", separator: ",", delimiter: ".")
  end

  # Formatea una fecha
  # @param date [Date, DateTime] fecha a formatear
  # @return [String] fecha formateada como "28/01/2026"
  def format_date(date)
    return "" if date.blank?
    date.strftime("%d/%m/%Y")
  end

  # Formatea una fecha y hora
  # @param datetime [DateTime] fecha y hora a formatear
  # @return [String] fecha y hora formateada como "28/01/2026 19:30"
  def format_datetime(datetime)
    return "" if datetime.blank?
    datetime.strftime("%d/%m/%Y %H:%M")
  end

  # Retorna la clase CSS apropiada para el tipo de flash message
  # @param level [Symbol, String] tipo de mensaje (:notice, :alert, :warning)
  # @return [String] clases CSS de Tailwind
  def flash_class(level)
    case level.to_sym
    when :notice
      "bg-green-100 border-green-500 text-green-700"
    when :alert
      "bg-red-100 border-red-500 text-red-700"
    when :warning
      "bg-yellow-100 border-yellow-500 text-yellow-700"
    else
      "bg-blue-100 border-blue-500 text-blue-700"
    end
  end

  # Retorna el ícono apropiado para el tipo de flash message
  # @param level [Symbol, String] tipo de mensaje
  # @return [String] emoji o ícono
  def flash_icon(level)
    case level.to_sym
    when :notice then "✅"
    when :alert then "❌"
    when :warning then "⚠️"
    else "ℹ️"
    end
  end
end

