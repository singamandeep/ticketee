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

	# ** we just do a fake login as warden cant be used here and
	# ** then we click on project link to handle the "red page".
	it "handles permission errors by redirecting to a safe place" do
		allow(controller).to receive(:current_user)

		project = FactoryGirl.create(:project)
		get :show, id: project

		expect(response).to redirect_to(root_path)
		message = "You aren't allowed to do that."
		expect(flash[:alert]).to eq message
	end
end
