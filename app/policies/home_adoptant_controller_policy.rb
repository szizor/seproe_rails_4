class HomeAdoptantControllerPolicy
  attr_reader :current_user, :model

  def initialize(current_user, target)
    @current_user = current_user
    @controller = target
  end

  def index?
    @current_user.present? && @current_user.adoptant?
  end

end