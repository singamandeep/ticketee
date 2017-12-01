require "rails_helper"

RSpec.feature "User can delete tickets" do
	let(:author) { FactoryGirl.create(:user) }
	let(:project) { FactoryGirl.create(:project) }
	let(:ticket) { FactoryGirl.create(:ticket, project: project, author: author) }

	before do
		# ** login was added afterwards to get the test pass in Ch-8
		# ** since anonymous user can't view a project 
		# ** we need to assign current user roles
		# ** and for assigning roles user must be signed in
		login_as(author)
		assign_role!(author, :manager, project)

		visit project_ticket_path(project, ticket)
	end

	scenario "successfully" do
		click_link "Delete Ticket"

		expect(page).to have_content "Ticket has been deleted."
		expect(page.current_url).to eq project_url(project)
	end

end