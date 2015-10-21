# encoding: utf-8
class ListingsController < ApplicationController
  before_action :set_listing, only: [:edit, :update, :destroy]

  def show
    @listings = Listing.order('name ASC').all
  	@listing = Listing.friendly.find params[:listing_name]
    @events = @listing.events.order('start_date DESC')
    @money = @listing.money.order('spent_date DESC')
    @money_js =  Money.find_by_sql("SELECT date(spent_date) as date, sum(amount) as total FROM money WHERE listing_id = #{@listing.id} GROUP BY EXTRACT(MONTH FROM spent_date),spent_date ")

  end

  def vote
    value = params[:type] == "up" ? 1 : 0
    @listing = Listing.friendly.find(params[:id])
    @listing.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Gracias por votar"
  end

  def espacios
    @listings = Listing.order('name ASC').all
    if current_user && current_user.adopter
      @my_listings = current_user.adopter.try(:listings)
    end
  end

  def images
    @listings = Listing.order('name ASC').all
    @listing = Listing.friendly.find(params[:listing_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listing }
    end
  end

  def new_image
    @listings = Listing.order('name ASC').all
    @listing = Listing.friendly.find(params[:listing_id])
    @image = Image.new(:listing_id => params[:listing_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  def save_image
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to listing_images_path(:listing_id => params[:listing_id]), 
          notice: 'Tu imagen está esperando moderación, se mostrará una vez que sea aprovada.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def videos
    @listings = Listing.order('name ASC').all
    @listing = Listing.friendly.find(params[:listing_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listing }
    end
  end

  def new_video
    @listings = Listing.order('name ASC').all
    @listing = Listing.friendly.find(params[:listing_id])
    @video = Video.new(:listing_id => params[:listing_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  def save_video
    @video = Video.new(params[:video])

    respond_to do |format|
      if @video.save
        format.html { redirect_to listing_videos_path(:listing_id => params[:listing_id]), notice: 'Video creado exitosamente' }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def dinero
    @listings = Listing.order('name ASC').all
    @listing = Listing.friendly.find(params[:listing_id])
    @money = @listing.money.order('spent_date DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listing }
    end
  end

  def new_dinero
    @listings = Listing.order('name ASC').all
    @listing = Listing.friendly.find(params[:listing_id])
    @money = Money.new(:listing_id => params[:listing_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @money }
    end
  end

  def save_dinero
    @money = Money.new(params[:money])

    respond_to do |format|
      if @money.save
        format.html { redirect_to listing_dinero_path(:listing_id => params[:listing_id]), notice: 'Se añadió satisfactoriamente inversión en espacio público' }
        format.json { render json: @money, status: :created, location: @money }
      else
        format.html { render action: "new" }
        format.json { render json: @money.errors, status: :unprocessable_entity }
      end
    end
  end

  def events
    @listings = Listing.order('name ASC').all
    @listing = Listing.friendly.find(params[:listing_id])
    @events = @listing.events

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def new_event
    @listings = Listing.order('name ASC').all
    @listing = Listing.friendly.find(params[:listing_id])
    @event = Event.new(:listing_id => params[:listing_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @money }
    end
  end

  def save_event
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to listing_events_path(:listing_id => params[:listing_id]), notice: 'Evento creado exitosamente' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_listing
    @listing = Listing.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def listing_params
    params.require(:listing).permit(:title, :body, :user_id)
  end

end