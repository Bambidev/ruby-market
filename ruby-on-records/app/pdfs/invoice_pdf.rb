class InvoicePdf < Prawn::Document
  def initialize(sale)
    super()
    @sale = sale
    header
    client_data
    items_table
    total_price
    footer
  end

  def header
    text "Ruby On Records", size: 24, style: :bold, align: :center
    text "Factura de Venta ##{@sale.id}", size: 18, align: :center
    move_down 20
  end

  def client_data
    text "Fecha: #{@sale.created_at.strftime("%d/%m/%Y %H:%M")}", size: 12
    text "Cliente: #{@sale.client.name}", size: 12
    text "DNI: #{@sale.client.dni}", size: 12
    text "Vendedor: #{@sale.user.full_name}", size: 12
    move_down 20
  end

  def items_table
    table_data = [["Producto", "Cantidad", "Precio Unitario", "Subtotal"]]
    @sale.items.each do |item|
      table_data << [
        item.disk.title,
        item.quantity,
        "$#{item.price}",
        "$#{item.quantity * item.price}"
      ]
    end
    table(table_data, header: true, width: bounds.width) do
      row(0).font_style = :bold
      columns(1..3).align = :right
    end
    move_down 20
  end

  def total_price
    text "Total: $#{@sale.total}", size: 16, style: :bold, align: :right
  end

  def footer
    move_down 20
    text "Gracias por tu compra!", align: :center, size: 12
    text "Ruby On Records - Av. Corrientes 1234, CABA", align: :center, size: 10
  end
end
