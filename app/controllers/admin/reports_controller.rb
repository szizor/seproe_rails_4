class Admin::ReportsController < Admin::BaseController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reports = Report.all
  end

  def cambio_estado
    @report = Report.find(params[:report_id])
    @report.update_attribute(:status, params[:status])
    respond_to do |format|
      format.html { redirect_to admin_reports_url }
      format.json { head :no_content }
    end
  end
  
  def show
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end
end