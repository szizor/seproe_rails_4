class Question < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_many :responses
  validates_presence_of :title, :body

  def should_generate_new_friendly_id?
    new_record?
  end

  def approve
    self.approved = true
    save
  end
end
