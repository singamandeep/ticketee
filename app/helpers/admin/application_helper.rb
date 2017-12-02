module Admin::ApplicationHelper
	def roles
=begin	it is a hash.
		{ 
			'Manager' => 'manager'
			'Editor' => 'editor'
			'Viewer' => 'viewer'
		}
=end
		hash = {}
		
		# ** available_roles is a class method defined in 'Role' model.
		Role.available_roles.each do |role|
			hash[role.titleize] = role
		end
		
		return hash
	end
end
