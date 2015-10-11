class Provider < ActiveRecord::Base
  # attr_accessible :name, :address, :phone, :facebook, :twitter, :email, :website, :description, :provider_category_id, :slug
  validates_presence_of :name, :facebook, :twitter, :email, :website
  belongs_to :provider_category
  extend FriendlyId
  friendly_id :name, use: :history
end