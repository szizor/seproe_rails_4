class Money < ActiveRecord::Base
  belongs_to :listings
  validates_presence_of :amount, :spent_date, :description
end
