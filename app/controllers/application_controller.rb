class ApplicationController < ActionController::Base
	include Pundit

	protect_from_forgery with: :exception

	# ** its a global rescue_from to rescue from Pundit errors.
	rescue_from Pundit::NotAuthorizedError, with: :not_authorized

private 

	def not_authorized
		flash[:alert] = "You aren't allowed to do that."
		redirect_to root_path
	end

end
