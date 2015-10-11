class ReportsController < ApplicationController

  def index
    @publicSpaces = Listing.all_listings
    @listings = Listing.order('name ASC').all
    @listings_available = Listing.all.order('name ASC')
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to reports_path, :notice => "Reporte creado exitosamente"
    else
      @publicSpaces = Listing.all_listings
      @listings = Listing.order('name ASC').all
      @listings_available = Listing.order('name ASC').find(:all, :conditions => { :listing_type_id => [1, 2] })
      render :action => 'index'
    end
  end
  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(:description, :listing_id, :photo, :priority, :status, :user_id, :report_type)
  end
end