class Project < ApplicationRecord

	# ** All associations here
	has_many :tickets, dependent: :delete_all
	has_many :roles, dependent: :delete_all

	# ** All validations here
	validates :name, presence: true

	def has_member?(user)
		roles.exists?(user_id: user)
	end

	# ** Ruby's Metaprogramming to define methods as
	# ** has_viewer?, has_editor?, has_manager?
	[:manager, :editor, :viewer].each do |role|
		# ** the arguments to the method are taken as block 
		# ** arguments.
		define_method "has_#{role}?" do |user|
			roles.exists?(user_id: user, role: role)	
		end
	end
end
