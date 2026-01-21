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

  private

  def client_params
    params.expect(client: [ :name, :dni ])
  end
end
