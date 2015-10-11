class UsersController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"

  def index
    @users = User.page(params[:page])
  end

  def new
  end

  def create
    if @user.save
      session[:user_id] = @user.id
      # redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
      return render :json => {:success => true, :notice => "Gracias por firmarse! A sido conectado."}
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update_attributes(params[:user])
      return render :json => {:success => true, :notice => "Perfil editado exitosamente"}
      # redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end

end