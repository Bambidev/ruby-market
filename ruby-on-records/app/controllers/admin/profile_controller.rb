# frozen_string_literal: true

class Admin::ProfileController < Admin::BaseController
  # ProfileController no tiene index, saltamos el callback del BaseController
  skip_before_action :set_collection, raise: false

  # GET /admin/profile
  def edit
    @user = current_user
  end

  # PATCH /admin/profile
  def update
    @user = current_user

    # No permitir cambiar el rol desde el perfil
    if user_params[:role].present? && user_params[:role] != @user.role
      redirect_to admin_profile_path, alert: "No puedes cambiar tu propio rol"
      return
    end

    if @user.update(user_params.except(:role))
      redirect_to admin_profile_path, notice: "Perfil actualizado exitosamente"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end
end
