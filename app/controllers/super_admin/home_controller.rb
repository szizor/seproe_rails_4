class SuperAdmin::HomeController < ApplicationController

  def index
  	authorize(self)
  end
end
