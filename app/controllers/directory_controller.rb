class DirectoryController < ApplicationController

  def index
    @publicSpaces = Listing.all_listings
    @listings = Listing.order('name ASC').all
  end

end