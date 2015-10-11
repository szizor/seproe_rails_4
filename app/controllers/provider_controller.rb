class ProviderController < ApplicationController

  def index
    @publicSpaces = Listing.all_listings
    @listings = Listing.order('name ASC').all
    @providers = Provider.order('created_at DESC').all
    categories = ProviderCategory.order('name ASC').all
    @provider_categories = categories.reject{|c| !c.providers.present? }
  end

  def category
  	@publicSpaces = Listing.all_listings
    @listings = Listing.order('name ASC').all
  	category = ProviderCategory.find_by_slug(params[:slug])
  	@providers = Provider.where(:provider_category_id => category.id).order('created_at DESC').all
  	categories = ProviderCategory.order('name ASC').all
    @provider_categories = categories.reject{|c| !c.providers.present? }
  end

end