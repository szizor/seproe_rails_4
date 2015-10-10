# encoding: utf-8
class Admin::AdoptersController < Admin::BaseController
  before_action :set_adopter, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @adopters = Adopter.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adopters }
    end
  end

  def show
  end

  def new
    @adopter = Adopter.new
    @users = User.where{id.not_in Adopter.select{user_id}.where("user_id is not null").uniq}
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @adopter }
    end
  end

  def edit
    @users = User.where{id.not_in Adopter.select{user_id}.where("user_id is not null").uniq}
  end

  def create
    if params[:adopter][:user_id]
      user = User.find_by_username(params[:adopter][:user_id])
      if user
        params[:adopter][:user_id] = user.id
      else
        params[:adopter][:user_id] = nil
      end
    end
    @adopter = Adopter.new(post_params)

    respond_to do |format|
      if @adopter.save
        format.html { redirect_to [:admin, @adopter], notice: 'Adoptante Creado Satisfactoriamente.' }
        format.json { render json: @adopter, status: :created, location: @adopter }
      else
        format.html { render action: "new" }
        format.json { render json: @adopter.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:adopter][:user_id]
      user = User.find_by_username(params[:adopter][:user_id])
      if user
        params[:adopter][:user_id] = user.id
      else
        params[:adopter][:user_id] = nil
      end
    end

    respond_to do |format|
      if @adopter.update_attributes(params[:adopter])
        format.html { redirect_to [:admin, @adopter], notice: 'Adoptante Editado Satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @adopter.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @adopter.destroy

    respond_to do |format|
      format.html { redirect_to admin_adopters_url }
      format.json { head :no_content }
    end
  end

  private

  def set_adopter
    @adopter = Adopter.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:adopter).permit(:url, :user_id, :nombre, :alias, :giro, :domicilio, :desired_listing_id, :telefono, :email, :expectativas, :interes, :logo, :acta, :ife, :razon, :facebook_url, :twitter_url, :contacts_attributes, :tipo)
  end

  def sort_column
    Listing.column_names.include?(params[:sort]) ? params[:sort] : "Nombre"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
