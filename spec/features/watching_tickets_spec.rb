require 'rails_helper'

RSpec.feature "Users can watch and unwatch tickets" do
	let(:user) { FactoryGirl.create(:user) }
	let(:project) { FactoryGirl.create(:project) }
	let(:ticket) do
		# since the user has created the ticket they would be already in the subscribers list.
		FactoryGirl.create(:ticket, project: project, author: user)
	end

	before do
		assign_role!(user, :viewer, project)
		login_as(user)
		visit project_ticket_path(project, ticket)
	end

	scenario "successfully" do
		# initially I was a watcher
		within("#watchers") do
			expect(page).to have_content user.email
		end
 		
 		# then I unwatched
		click_link "Unwatch"
		expect(page).to have_content "You are no longer watching this ticket."

		within("#watchers") do
			expect(page).to_not have_content user.email
		end

		# Now I want to watch again.
		click_link "Watch"
		expect(page).to have_content "You are now watching this ticket."

		within("#watchers") do
			expect(page).to have_content user.email
		end
	end
end