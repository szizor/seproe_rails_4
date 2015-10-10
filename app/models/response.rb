class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  def approve
  	self.approved = true
  	save
  end
end
