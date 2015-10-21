class Account < ActiveRecord::Base

	has_many :users
	has_one :owner, -> { where("role_id = ?", Role.find_by_name("Administrador").id ).order("created_at ASC") }, dependent: :destroy	
	accepts_nested_attributes_for :owner

	validates :name, presence: true
	validates :subdomain, presence:true
	validates :subdomain, uniqueness:true 

end
