class Admin::ResponsesController < Admin::BaseController
	before_filter :authorize_admin

  def approve
  	@response = Response.find(params[:id])
  	render({json: {approved: @response.approve} })
  end

  def authorize_admin
    redirect_to root_url, :alert => "Not authorized" unless current_user && current_user.role?(:administrador)
  end
end
