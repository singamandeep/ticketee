=begin 
	CRUD :
	C - Create - new and create.
	R - view or read - index and show.
	U - Update - edit and update(put/patch).
	D - delete - destroy.
=end

class ProjectsController < ApplicationController
	
	before_action :set_project, only: [:show, :edit, :update, :destroy]

	def index
		# ** before authorization "@projects = Project.all"
		# ** this is similar as writing
		# ** ProjectPolicy::Scope.new(current_user, Project).resolve
		# ** Here current_user is passed automatically.
		# ** But we are passing it explicitly in testing.
		@projects = policy_scope(Project)
	end

	def show
		authorize @project, :show?
		@tickets = @project.tickets
	end

	def edit 
		authorize @project, :update?
	end 

	def update
		authorize @project, :update?
		
		if @project.update(project_params)
			flash[:notice] = "Project has been updated."
			redirect_to @project # going to show
		else
			flash.now[:alert] = "Project has not been updated."
			render "edit"
		end
	end

private

	def project_params
		params.require(:project).permit(:name, :description)
	end

	def set_project
		@project = Project.find(params[:id])

	rescue ActiveRecord::RecordNotFound
		flash[:alert] = "The project you were looking for could not be found."
		redirect_to projects_path

	end 

	
end
