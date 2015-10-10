# encoding: utf-8
class Admin::ImagesController < Admin::BaseController
  load_and_authorize_resource

  def index
    @listing = Listing.find(params[:listing_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listing }
    end
  end
  
  def approve
    @image = Image.find(params[:id])
    
    @image.approved = true
    @image.save

    redirect_to admin_listing_images_path
  end

  def show
    @image = Image.find(params[:id])

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
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(params[:image])

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
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:event])
        listing = Listing.find(params[:listing_id])
        format.html { redirect_to admin_listing_images_path(listing), notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to admin_listing_images_path(:listing_id => params[:listing_id]), notice: 'Image was successfully deleted.'  }
      format.json { head :no_content }
    end
  end
end