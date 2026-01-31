class Admin::GenresController < Admin::BaseController
  before_action :set_genre, only: %i[show edit update destroy]

  # GET /admin/genres
  def index
    @genres = Genre.order(:genre_name)
  end

  # GET /admin/genres/1
  def show
    @disks = @genre.disks.order(:title).page(params[:page])
  end

  # GET /admin/genres/new
  def new
    @genre = Genre.new
  end

  # GET /admin/genres/1/edit
  def edit
  end

  # POST /admin/genres
  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to admin_genres_path, notice: "Género creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/genres/1
  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "Género actualizado exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/genres/1
  def destroy
    if @genre.disks.any?
      redirect_to admin_genres_path, alert: "No se puede eliminar un género con discos asociados."
    else
      @genre.destroy!
      redirect_to admin_genres_path, notice: "Género eliminado exitosamente."
    end
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:genre_name)
  end
end
