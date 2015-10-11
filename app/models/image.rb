class Image < ActiveRecord::Base
  # attr_accessible :image, :listing_id, :remote_image_url
  mount_uploader :image, ImageUploader
end