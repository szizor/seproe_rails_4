class SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  prepend_before_filter :allow_params_authentication!, :only => :create
  prepend_before_filter :only => [ :create, :destroy ] { request.env["devise.skip_timeout"] = true }

  def create
    @listings = Listing.order('name ASC').all
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_in_and_redirect(resource_name, resource)
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    @listings = Listing.order('name ASC').all
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    redirect_to root_url
    #return render :json => {:success => true}
  end

  def failure
    @listings = Listing.order('name ASC').all
    return render :json => {:success => false, :errors => ["Nombre de Usuario o Password Invalidos"]}
  end

  def destroy
    @listings = Listing.order('name ASC').all
    warden.logout
    redirect_to root_path
    # return render :json => {:success => true}
  end
end