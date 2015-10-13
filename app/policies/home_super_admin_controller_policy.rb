class HomeSuperAdminControllerPolicy
  attr_reader :current_user, :model

  def initialize(current_user, target)
    @current_user = current_user
    @controller = target
  end

  def index?
    @current_user.present? && @current_user.super_admin?
  end

end