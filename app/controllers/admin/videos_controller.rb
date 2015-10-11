class Admin::VideosController < Admin::BaseController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
 
  def index
    @listing = Listing.friendly.find(params[:listing_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listing }
    end
  end

  def show
  end

  def new
    @video = Video.new(:listing_id => params[:listing_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  def edit
  end

  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to admin_listing_videos_path(:listing_id => params[:listing_id]), notice: 'Video creado exitosamente' }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to [:admin, @video], notice: 'Video editado exitosamente' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @video.destroy

    respond_to do |format|
      format.html { redirect_to admin_listing_videos_path(:listing_id => params[:listing_id]) }
      format.json { head :no_content }
    end
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:url, :user_id, :listing_id, :title)
    end
end