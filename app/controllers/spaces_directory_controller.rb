class SpacesDirectoryController < ApplicationController

  def index
  	@domain = request.domain
  	@port = request.port.to_s
  	@spaces = Account.all
  end
end
