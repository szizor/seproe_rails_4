class UsersController < ApplicationController

before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = policy_scope(User)
    authorize User
  end

  def edit
    authorize @user    
  end

  def new
    @user = User.new
    authorize @user    
  end

  def update
    authorize @user    
    #Remove password params if they are empty, then won't be updted
    if params[:user][:password].blank? 
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end    
    if @user.update(user_params)
      redirect_to users_path, notice: 'Usuario actualizado correctamente .'
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      redirect_to users_path, notice: 'Usuario creado correctamente .'
    else
      render :new
    end
  end

  def destroy
    authorize @user    
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Usuario destruido correctamente .' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit( :email, :password, :password_confirmation,:role_id, :account_id )
    end


end
