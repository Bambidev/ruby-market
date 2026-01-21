class Admin::DisksController < Admin::BaseController
  load_and_authorize_resource

  # GET /admin/disks
  def index
  end

  private

  def set_collection
    @disks = Disk.by_state(params[:filter])
  end

  # GET /admin/disks/1
  def show
  end

  # GET /admin/disks/new
  def new
    @disk = Disk.new
  end

  # GET /admin/disks/1/edit
  def edit
  end

  # POST /admin/disks
  def create
    @disk = Disk.new(disk_params)

    respond_to do |format|
      if @disk.save
        format.html { redirect_to [ :admin, @disk ], notice: "Disco creado exitosamente." }
        format.json { render :show, status: :created, location: [ :admin, @disk ] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @disk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/disks/1
  def update
    respond_to do |format|
      if @disk.update(disk_params)
        format.html { redirect_to [ :admin, @disk ], notice: "Disco actualizado exitosamente.", status: :see_other }
        format.json { render :show, status: :ok, location: [ :admin, @disk ] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @disk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/disks/1
  def destroy
    @disk.destroy!

    respond_to do |format|
      format.html { redirect_to admin_disks_path, notice: "Disco eliminado exitosamente.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def disk_params
    params.expect(disk: [ :title, :artist, :year, :description, :price, :stock, :format, :state ])
  end
end
