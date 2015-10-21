class HomeController < ApplicationController
  # before_action :set_home, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.present?
      if current_user.admin?
        redirect_to admin_home_path
        return
      elsif current_user.super_admin?
        redirect_to super_admin_home_path
        return
      end
    end
    #else guest # or adoptant
    @publicSpaces = Listing.all_listings
  	@user = User.new
    @listings = Listing.paginate(:page => params[:page], :per_page => 21).order('name ASC')
    @sidebar_listings = Listing.order('name ASC').all
  end

  def show
    @listings = Listing.order('name ASC').all
  	@listing = Listing.find params[:listing_name]
  end

  def adoptar
    @adopter = Adopter.new
    @contact = @adopter.contacts.build
    @listings = Listing.order('name ASC').all
    @listings_available = Listing.where(:listing_type_id => [1, 2]).order('name ASC')
  end

  def create_adopter
    @adopter = Adopter.new(params[:adopter])
    respond_to do |format|
      if @adopter.save
        if @adopter.tipo.downcase == "fisica"
          params[:user][:email] = @adopter.contacts.first.email
        else
          params[:user][:email] = @adopter.email
        end
        params[:user][:status] = "Pendiente"
        user = User.create(params[:user])
        user.adopter = @adopter if user
        user.roles << Role.where(:name => "Adoptante")
        user.roles.delete(Role.find(3))
        UserMailer.adopter_registration_confirmation(@adopter).deliver
        AdoptionRequest.create(adopter_id: @adopter.id, listing_id: @adopter.desired_listing_id, status: 1)
        format.html { redirect_to adoptar_home_index_path, notice: "Te agradecemos tu interés en adoptar un espacio público de la ciudad de Guadalajara. Con gusto revisaremos la información que nos envias y la disponibilidad del espacio solicitado para ponernos en contacto contigo a la brevedad posible." }
      else
        @listings = Listing.order('name ASC').all
        @listings_available = Listing.order('name ASC').find(:all, :conditions => { :listing_type_id => [1, 2] })
        format.html { render action: "adoptar" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  
end
