class API::TicketsController < ApplicationController
	before_action :authenticate_user
	before_action :set_project
	before_action :set_ticket
	attr_reader :current_user

	def show 
		authorize @ticket, :show?
		render json: @ticket
	end

	private

	def set_project
		@project = Project.find(params[:project_id])
	end

	def set_ticket
		@ticket = Ticket.find(params[:id])
	end

	def authenticate_user
		authenticate_with_http_token do |token|
			@current_user = User.find_by(api_key: token)
		end
	end
end
