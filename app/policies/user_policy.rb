class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, target)
    @current_user = current_user
    @user = target
  end

  def index?
    is_super_admin?
  end

  def edit?
    is_super_admin?
  end

  def update?
    is_super_admin?
  end

  def destroy?
    is_super_admin?
  end

  def new?
    is_super_admin?
  end

  def create?
    is_super_admin?
  end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.present? && user.super_admin?
        scope.all
      elsif user.present? && user.admin?
        user.account.users
      end
    end
  end

  private 
    def is_super_admin?
      @current_user.present? && @current_user.super_admin?
    end
end