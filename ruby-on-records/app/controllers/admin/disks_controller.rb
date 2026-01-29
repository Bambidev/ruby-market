class Admin::DisksController < Admin::BaseController
  before_action :set_disk, only: %i[show edit update destroy]
  before_action :load_genres, only: %i[new edit create update]

  # GET /admin/disks
  def index
    @disks = Disk.includes(:genres).order(created_at: :desc)
    
    # Filtro por búsqueda de texto
    if params[:q].present?
      @disks = @disks.search(params[:q])
    end
    
    # Filtro por género
    if params[:genre_id].present?
      @disks = @disks.joins(:genres).where(genres: { id: params[:genre_id] })
    end
    
    # Filtro por formato
    if params[:format_filter].present?
      @disks = @disks.where(format: params[:format_filter])
    end
    
    # Filtro por estado
    if params[:state].present?
      @disks = @disks.where(state: params[:state])
    end
    
    # Filtro por stock
    case params[:stock]
    when "in_stock"
      @disks = @disks.in_stock
    when "out_of_stock"
      @disks = @disks.out_of_stock
    end
    
    # Filtro por año
    if params[:year].present?
      @disks = @disks.where(year: params[:year])
    end
    
    @disks = @disks.page(params[:page])
    @genres = Genre.order(:genre_name)
    @years = Disk.distinct.order(year: :desc).pluck(:year)
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

    if @disk.save
      redirect_to [:admin, @disk], notice: "Disco creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/disks/1
  def update
    if @disk.update(disk_params)
      redirect_to [:admin, @disk], notice: "Disco actualizado exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/disks/1
  def destroy
    @disk.destroy!
    redirect_to admin_disks_path, notice: "Disco eliminado exitosamente."
  end

  private

  def set_disk
    @disk = Disk.find(params[:id])
  end

  def load_genres
    @genres = Genre.order(:genre_name)
  end

  def disk_params
    params.require(:disk).permit(
      :title, :artist, :year, :description, :price, :stock, :format, :state,
      :cover, :preview,
      photos: [],
      genre_ids: []
    )
  end
end
