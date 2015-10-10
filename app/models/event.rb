class Event < ActiveRecord::Base
  has_many :videos
  has_many :photos
  belongs_to :adopter
  belongs_to :user
  belongs_to :listing
  mount_uploader :image, ImageUploader
  validates_presence_of :name, :description
end
