class Listing < ActiveRecord::Base
  belongs_to :listing_type
  belongs_to :adopter
  has_many :adoption_requests
  has_many :events
  has_many :images
  has_many :videos
  has_many :money
  mount_uploader :cover_image, CoverImageUploader
  #validate :validate_minimum_image_size, :if => Proc.new { |listing| listing.cover_image_changed?}
  validates_presence_of :name , :category, :location
  has_reputation :votes, source: :user, aggregated_by: :sum

  extend FriendlyId
  friendly_id :name, use: :history

  attr_accessor :image_width, :image_height

  def approved_images
    images.where(approved: true)
  end

  def adopter_name
    adopter.try(:nombre)
  end

  def adopter_name=(nombre)
    self.adopter = Adopter.find_by_nombre(nombre) if nombre.present?
  end

  class << self

    def geocode(address)
      Geocoder.search(address).first.data["geometry"]["location"]
    end

    def data_adopted(from = (Date.today-1.month).beginning_of_day,to = Date.today.end_of_day)
      where(created_at: from..to, listing_type_id: 3).group('date(created_at)').count
    end

    def data_free(from = (Date.today-1.month).beginning_of_day,to = Date.today.end_of_day)
      where(created_at: from..to, listing_type_id: 1).group('date(created_at)').count
    end

    def data_inprocess(from = (Date.today-1.month).beginning_of_day,to = Date.today.end_of_day)
      where(created_at: from..to, listing_type_id: 2).group('date(created_at)').count
    end

    def all_listings
      all_listings =
      {
        "type" => "FeatureCollection",
        "features" =>
          Listing.order('created_at DESC').all.map do |u|
            {
              "type" => "Feature",
              "properties" => {
                "title"=> u.name,
                "tag" => "tag",
                "type" => u.listing_type.name,
                "is_featured" => u.is_featured,
                "updated"=> u.updated_at.strftime("%d/%b/%Y %H:%M"),
                "cover" => u.cover_image.present? ? u.cover_image.url : "/images/listing_cover.jpg",
                "cover_thumb" => u.cover_image.present? ? u.cover_image.url(:thumb) : "/images/listing_cover.jpg",
                "street"=> u.location,
                "locality" => "Guadalajara",
                "region" => "Jal",
                "postal" => u.postal,
                "url" => "#{u.slug}",
                "company"=> u.adopter ? u.adopter.display_name : "",
                "company_url"=> u.adopter ? u.adopter.url : "",
                "company_facebook" => u.adopter ? u.adopter.facebook_url : "",
                "company_twitter" => u.adopter ? u.adopter.twitter_url : "",
              },
              "geometry" => {
                "type" => "Point",
                "coordinates" => [
                  u.latitude,
                  u.longitude
                ]
              }
            }
          end
      }
      all_listings
    end
  
  end
end
