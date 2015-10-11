class EventController < ApplicationController

  def index
    @publicSpaces = Listing.all_listings
    @listings = Listing.order('name ASC').all
    @username
    events =
      Event.order('start_date DESC').all.map do |u|
        if u.user.present? && u.listing.present? && u.listing.name.present?  
          {
              "id"          => u.id,
              "title"       => u.name,
              "start"       => u.start_date,
              "end"         => u.end_date,
              "listing"     => u.listing.name,
              "url"         => u.listing.slug+'?event='+u.id.to_s,
              "created_by"  => u.user.username
          }
        end
      end
    @events = events.compact
  end

end