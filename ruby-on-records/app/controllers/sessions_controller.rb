class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    # Formulario de login
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "¡Bienvenido, #{user.full_name}!"
    else
      flash.now[:alert] = "Email o contraseña incorrectos"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Has cerrado sesión"
  end
end
