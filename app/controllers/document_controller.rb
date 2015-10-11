class DocumentController < ApplicationController

  def index
    @publicSpaces = Listing.all_listings
    @listings = Listing.order('name ASC').all
    @documents = Document.order('created_at DESC').all
  end

  def download
  	doc = Document.find(params[:document_id])
  	send_file(doc.file.path,
              :disposition => 'attachment',
              :url_based_filename => false)
  end

end