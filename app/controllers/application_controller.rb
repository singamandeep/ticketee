class ApplicationController < ActionController::Base
	include Pundit

	protect_from_forgery with: :exception

	# ** its a global rescue_from to rescue from Pundit errors.
	rescue_from Pundit::NotAuthorizedError, with: :not_authorized

	# ** to avoid making mistakes added authorize check on every exisiting and future coming controllers
	# ** except on devise
	after_action :verify_authorized, except: [:index], unless: :devise_controller?
	after_action :verify_policy_scoped, only: [:index], unless: :devise_controller?

private 

	def not_authorized
		flash[:alert] = "You aren't allowed to do that."
		redirect_to root_path
	end

end
