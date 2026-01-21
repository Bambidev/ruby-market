class Admin::GenresController < Admin::BaseController
  load_and_authorize_resource

  # GET /admin/genres
  def index
  end

  # GET /admin/genres/1
  def show
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

    respond_to do |format|
      if @genre.save
        format.html { redirect_to [ :admin, @genre ], notice: "Genero creado exitosamente." }
        format.json { render :show, status: :created, location: [ :admin, @genre ] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/genres/1
  def update
    respond_to do |format|
      if @genre.update(genre_params)
        format.html { redirect_to [ :admin, @genre ], notice: "Genero actualizado exitosamente.", status: :see_other }
        format.json { render :show, status: :ok, location: [ :admin, @genre ] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/genres/1
  def destroy
    @genre.destroy!

    respond_to do |format|
      format.html { redirect_to admin_genres_path, notice: "Genero eliminado exitosamente.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def genre_params
    params.expect(genre: [ :genre_name ])
  end
end
