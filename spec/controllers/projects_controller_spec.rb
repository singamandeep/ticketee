require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
	it "handles a missing project correctly" do

		# ** since this is test for projects controller
		# the :show action will be used of projects
		get :show, id: "not-here"

		expect(response).to redirect_to(projects_path)

		message = "The project you were looking for could not be found."
		expect(flash[:alert]).to eq message
		
	end
end
