class Admin::ListingsController < Admin::BaseController
  helper_method :sort_column, :sort_direction
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def index
    if params[:adoptante].present?
      @listings = Listing.joins(:adopter).where("name like '%#{params[:nombre]}%' AND adopters.nombre like '%#{params[:adoptante]}%'")
    else
      @listings = Listing.where("name like '%#{params[:nombre]}%'").order(sort_column + " " + sort_direction)
    end
  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def edit
  end

  def create
    @listing = Listing.new(listing_params)
    if params[:listing][:adopter_name]
      @listing.adopter_id = Adopter.find_by_nombre(params[:listing][:adopter_name])
    end
    respond_to do |format|
      if @listing.save
        format.html { redirect_to [:admin, @listing], notice: 'Listing was successfully created.' }
        format.json { render json: @listing, status: :created, location: @listing }
      else
        format.html { render action: "new" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @listing.update_attribute(:adopted_at, Time.now) if @listing.adopter_name != params[:listing][:adopter_name]
      if @listing.update_attributes(params[:listing])
        format.html { redirect_to admin_listings_url, notice: 'Listing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to admin_listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def geocode
    @latlong = Listing.geocode(params[:address])
    render :json => @latlong.to_json
  end

  def reset_votes
    @listing = Listing.friendly.find(params[:listing_id])
    evaluations = @listing.evaluations
    evaluations.each do |eval|
      eval.destroy
    end
    reputations = @listing.reputations
    reputations.each do |rep|
      rep.destroy
    end
    respond_to do |format|
      format.html { redirect_to admin_listings_url }
      format.json { head :no_content }
    end
  end

  private
    def set_listing
      @listing = Listing.friendly.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:adopter_id, :latitude, :description, :cover_image, :category, :location, :longitude, :name, :subtitle, :postal, :is_featured, :listing_type_id, :dimensions,:adopter_name, :slug)
    end

    def sort_column
      if params[:sort] == "Estado"
        params[:sort] = "listing_type_id"
      end
      Listing.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
