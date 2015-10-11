class Video < ActiveRecord::Base
  # attr_accessible :url, :user_id, :listing_id, :title
  belongs_to :users 
  belongs_to :listing
end