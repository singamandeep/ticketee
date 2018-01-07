class API::TicketsController < API::ApplicationController
	before_action :set_project
	before_action :set_ticket, only: [:show]

	def show 
		authorize @ticket, :show?
		render json: @ticket
	end

	def create
		@ticket = @project.tickets.build(ticket_params)
		@ticket.author = @current_user
		
		authorize @ticket, :create?

		if @ticket.save
			render json: @ticket, status: 201
		else
			render json: { errors: @ticket.errors.full_messages }, status: 422
		end
	end

	private

	def set_project
		@project = Project.find(params[:project_id])
	end

	def set_ticket
		@ticket = Ticket.find(params[:id])
	end

	def ticket_params
		params.require(:ticket).permit(:name, :description)
	end
end
