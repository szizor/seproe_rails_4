class Admin::ImagesController < Admin::BaseController
  before_action :set_image, only: [:show, :edit, :update, :destroy, :approve]

  def index
    @listing = Listing.friendly.find(params[:listing_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listing }
    end
  end
  
  def approve
    @image.approved = true
    @image.save

    redirect_to admin_listing_images_path
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  def new
    @image = Image.new(:listing_id => params[:listing_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  def edit
  end

  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to admin_listing_images_path(:listing_id => params[:listing_id]), notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @image.update(image_params)
        listing = Listing.friendly.find(params[:listing_id])
        format.html { redirect_to admin_listing_images_path(listing), notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image.destroy

    respond_to do |format|
      format.html { redirect_to admin_listing_images_path(:listing_id => params[:listing_id]), notice: 'Image was successfully deleted.'  }
      format.json { head :no_content }
    end
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:image, :listing_id, :remote_image_url)
    end

end