# frozen_string_literal: true

class Admin::SalesController < Admin::BaseController
  load_and_authorize_resource except: %i[index new create search_client search_disks]

  # GET /admin/sales
  def index
    @sales = Sale.includes(:client, :user, items: :disk)
                 .order(created_at: :desc)
                 .page(params[:page])
  end

  # GET /admin/sales/1
  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@sale)
        send_data pdf.render,
                  filename: "factura_#{@sale.id}.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  # GET /admin/sales/new
  def new
    @sale = Sale.new
    load_form_data
  end

  # POST /admin/sales
  def create
    # Validaciones básicas antes de procesar
    if sale_params[:client_id].blank? && sale_params[:client_attributes].blank?
      @sale = Sale.new
      @sale.errors.add(:base, "Debe seleccionar o crear un cliente")
      load_form_data
      render :new, status: :unprocessable_entity
      return
    end

    if sale_params[:items_attributes].blank?
      @sale = Sale.new(sale_params)
      @sale.errors.add(:base, "Debe agregar al menos un producto")
      load_form_data
      render :new, status: :unprocessable_entity
      return
    end

    result = Sales::Creator.new(sale_params, current_user).call

    if result.success?
      redirect_to admin_sales_path, notice: "Venta registrada exitosamente"
    else
      @sale = Sale.new(sale_params)
      @sale.errors.add(:base, result.errors.join(", "))
      load_form_data
      render :new, status: :unprocessable_entity
    end
  end

  # GET /admin/sales/search_client
  # Búsqueda de cliente por DNI - responde JSON
  def search_client
    dni = params[:dni].to_s.strip
    client = Client.find_by(dni: dni) if dni.present?

    render json: if client
                   {
                     found: true,
                     id: client.id,
                     name: client.name,
                     dni: client.dni,
                     email: client.email,
                     phone: client.phone
                   }
                 else
                   { found: false, dni: dni }
                 end
  end

  # GET /admin/sales/search_disks
  # Búsqueda de discos - responde JSON
  def search_disks
    query = params[:query].to_s.strip
    
    disks = if query.present?
              Disk.search(query).in_stock.limit(10)
            else
              []
            end

    render json: {
      found: disks.any?,
      disks: disks.map do |disk|
        {
          id: disk.id,
          title: disk.title,
          artist: disk.artist,
          format: disk.format,
          stock: disk.stock,
          price: disk.price.to_f
        }
      end
    }
  end

  # POST /admin/sales/1/cancel
  def cancel
    result = Sales::Canceller.new(@sale).call

    if result.success?
      redirect_to admin_sales_path, notice: "Venta cancelada exitosamente. Stock devuelto"
    else
      redirect_to admin_sales_path, alert: result.errors.join(", ")
    end
  end

  private

  # Carga datos necesarios para el formulario
  def load_form_data
    @disks = Disk.in_stock.order(:title)
  end

  # Strong parameters
  def sale_params
    params.require(:sale).permit(
      :client_id,
      client_attributes: %i[name dni email phone],
      items_attributes: %i[id disk_id quantity price _destroy]
    )
  end
end
