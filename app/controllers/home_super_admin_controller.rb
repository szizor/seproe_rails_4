class HomeSuperAdminController < ApplicationController

  def index
  	authorize(self)
  end
end
