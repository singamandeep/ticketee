class Admin::ApplicationController < ApplicationController
  	before_action :authorize_admin!
  	skip_after_action :verify_authorized, :verify_policy_scoped

  	def index
  	end

private 
	def authorize_admin!
		authenticate_user! # ** given by Devise

		# ** the admin method comes from the 
		# ** attributes set in the database and 
		# ** it exists for each attribute of the database
		unless current_user.admin? 
			redirect_to root_path
			flash[:alert] = "You must be an admin to do that."
		end
	end

end
