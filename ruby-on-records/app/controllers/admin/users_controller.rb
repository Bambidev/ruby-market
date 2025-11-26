class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_admin

  # GET /admin/users
  def index
    @users = User.all
  end

  # GET /admin/users/1
  def show
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to [:admin, @user], notice: "Usuario creado exitosamente." }
        format.json { render :show, status: :created, location: [:admin, @user] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to [:admin, @user], notice: "Usuario actualizado exitosamente.", status: :see_other }
        format.json { render :show, status: :ok, location: [:admin, @user] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: "Usuario eliminado exitosamente.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params.expect(:id))
    end

    def user_params
      params.expect(user: [ :full_name, :email, :password, :password_confirmation, :role ])
    end
end
