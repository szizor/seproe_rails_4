class Contact < ActiveRecord::Base
  belongs_to :adopter
  validates_presence_of :name, :phone, :cell, :email
  mount_uploader :ife, GenericUploader
end
