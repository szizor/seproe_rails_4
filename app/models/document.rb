class Document < ActiveRecord::Base
  validates_presence_of :title, :file
  mount_uploader :file, GenericUploader
end
