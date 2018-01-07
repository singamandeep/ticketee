class API::ApplicationController < ApplicationController
	before_action :authenticate_user
	attr_reader :current_user

	private

	def authenticate_user
		authenticate_with_http_token do |token|
			@current_user = User.find_by(api_key: token)
		end

		if @current_user.nil?
			render json: { error: "Unauthorized" }, status: 401
			return
		end
	end

	def not_authorized
		render json: { error: "Unauthorized" }, status: 403
		# return  - here no need to return as rest is setteled by Pundit.
	end
end
