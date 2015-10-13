class HomeAdoptantController < ApplicationController
  def index
  	authorize(self)
  end
end
