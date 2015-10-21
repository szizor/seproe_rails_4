class Role < ActiveRecord::Base

	scope :local_roles, -> {where("name != ?", "Super Administrador" )}

	has_and_belongs_to_many :users
	
	validates :name, presence: true


end
