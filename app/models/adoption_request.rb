class AdoptionRequest < ActiveRecord::Base
  after_create :set_in_process
  belongs_to :adopter
  belongs_to :listing

  def approve
  	self.status = 2
  	listing.adopter_id = adopter_id
    listing.adopted_at = Time.now
  	listing.listing_type_id = 3
  	listing.save
  	save
  end

  def reject
  	self.status = 3
  	listing.listing_type = ListingType.find(3)
  	listing.save
  	save
  end

  def display_status
  	case status
	  	when 1
	  		"En Proceso"
	  	when 2
	  		"Aceptado"
	  	when 3
	  		"Rechazado"
	 end
  end

  private
  def set_in_process
  	listing.listing_type = ListingType.find(2)
  	listing.save
  end
end
