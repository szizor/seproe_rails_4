# encoding: utf-8
class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.where("username like '%#{params[:usuario]}%'").paginate(:page => params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.account_id = current_user.account_id
    if @user.save
      session[:user_id] = @user.id
      redirect_to admin_users_url, :notice => "Usuario creado con exito"
      #return render :json => {:success => true, :notice => "Thank you for signing up! You are now logged in."}
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      # return render :json => {:success => true, :notice => "Your profile has been updated."}
      redirect_to admin_users_url, :notice => "Usuario editado con exito"
    else
      render :action => 'edit'
    end
  end

  def destroy
    #if @user.id == 1
    #  respond_to do |format|
    #    format.html { redirect_to admin_users_url, :notice => "No Puede eliminar al Administrador" }
    #    format.json { head :no_content }
    #  end
    #else
      if @user.adoptant?
        @user.adopter.listings.each do |listing|
          listing.update_attribute(:adopter_id, nil)
        end if @user.adopter
      elsif @user.admin?
        @user.questions.each do |question|
          question.update_attribute(:user_id, User.first.id)
        end
        @user.responses.each do |question|
          question.update_attribute(:user_id, User.first.id)
        end
        @user.images.each do |question|
          question.update_attribute(:user_id, User.first.id)
        end
        @user.videos.each do |question|
          question.update_attribute(:user_id, User.first.id)
        end
        @user.events.each do |question|
          question.update_attribute(:user_id, User.first.id)
        end
        @user.money.each do |question|
          question.update_attribute(:user_id, User.first.id)
        end
      end
      @user.destroy

      respond_to do |format|
        format.html { redirect_to admin_users_url, :notice => "Usuario eliminado" }
        format.json { head :no_content }
      end
    #end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :username, :role_id, :adopter_attributes)
    end

end
