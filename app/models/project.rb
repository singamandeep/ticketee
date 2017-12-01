class Project < ApplicationRecord

	# ** All associations here
	has_many :tickets, dependent: :delete_all
	has_many :roles, dependent: :delete_all

	# ** All validations here
	validates :name, presence: true
end
