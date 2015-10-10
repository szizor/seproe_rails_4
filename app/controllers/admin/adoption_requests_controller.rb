class Admin::AdoptionRequestsController < Admin::BaseController

  def index
  	@adoption_requests = AdoptionRequest.order('status ASC').all
  end

  def approve
  	@adoption_request = AdoptionRequest.find(params[:id])
  	@adoption_request.approve

  	flash[:notice] = "Solicitud aceptada"
	respond_to do |format|
      format.html { redirect_to admin_adoption_requests_url }
      format.json { head :no_content }
    end
  end

  def reject
  	@adoption_request = AdoptionRequest.find(params[:id])
  	@adoption_request.reject

  	flash[:notice] = "Solicitud rechazada"
	respond_to do |format|
      format.html { redirect_to admin_adoption_requests_url }
      format.json { head :no_content }
    end
  end

  def destroy
    @adoption_request = AdoptionRequest.find(params[:id])
    @adoption_request.destroy

    respond_to do |format|
      format.html { redirect_to admin_adoption_requests_url }
      format.json { head :no_content }
    end
  end
end
