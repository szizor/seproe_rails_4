class HomeAdminController < ApplicationController
  def index
  	authorize(self)
  end
end
