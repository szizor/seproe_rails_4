class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::AuthorizationNotPerformedError, with: :user_not_authorized

    def user_not_authorized
      flash[:alert] = "No estas autorizado para realizar esta acción."
      redirect_to(root_path)
    end   

  def after_sign_in_path_for(resource)
    root_path
  end

end
