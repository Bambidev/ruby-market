class Admin::ClientsController < Admin::BaseController
  load_and_authorize_resource

  # GET /admin/clients
  def index
  end

  # GET /admin/clients/1
  def show
  end

  # GET /admin/clients/new
  def new
    @client = Client.new
  end

  # GET /admin/clients/1/edit
  def edit
  end

  # POST /admin/clients
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to [ :admin, @client ], notice: "Cliente creado exitosamente." }
        format.json { render :show, status: :created, location: [ :admin, @client ] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/clients/1
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to [ :admin, @client ], notice: "Cliente actualizado exitosamente.", status: :see_other }
        format.json { render :show, status: :ok, location: [ :admin, @client ] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/clients/1
  def destroy
    @client.destroy!

    respond_to do |format|
      format.html { redirect_to admin_clients_path, notice: "Cliente eliminado exitosamente.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /admin/clients/search?q=query
  # Endpoint para autocompletado AJAX
  def search
    @clients = if params[:q].present?
      Client.search(params[:q]).recent.limit(10)
    else
      Client.recent.limit(10)
    end

    render json: @clients.map { |client| 
      {
        id: client.id,
        text: client.display_name,
        name: client.name,
        dni: client.dni,
        email: client.email,
        phone: client.phone
      }
    }
  end

  # POST /admin/clients/quick_create
  # Creación rápida desde modal (usado en formulario de ventas)
  def quick_create
    @client = Client.new(client_params)

    if @client.save
      render json: {
        success: true,
        client: {
          id: @client.id,
          text: @client.display_name,
          name: @client.name,
          dni: @client.dni,
          email: @client.email,
          phone: @client.phone
        },
        message: "Cliente creado exitosamente"
      }, status: :created
    else
      render json: {
        success: false,
        errors: @client.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.expect(client: [ :name, :dni, :email, :phone ])
  end
end
