class ProviderCategory < ActiveRecord::Base
  extend FriendlyId
  # attr_accessible :name, :slug
  validates_presence_of :name
  has_many :providers
  friendly_id :name, use: :slugged
end