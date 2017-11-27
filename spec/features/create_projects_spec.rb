require 'rails_helper'

RSpec.feature "User can create new projects" do 
	scenario "with valid attributes" do
		
		visit "/"

		click_link "New Project"

		# ** here "Name" and "Description" are label names.
		fill_in "Name", with: "Sublime Text 3"
		fill_in "Description", with: "A Text Editor for everyone"
		click_button "Create Project"

		expect(page).to have_content "Project has been created."

		# ** this checks that we are on the right show action.
		project = Project.find_by(name: "Sublime Text 3")
		expect(page.current_url).to eq project_url(project)

		# ** This checks that we have the expected title.
		title = "Sublime Text 3 - Projects - Ticketee"
		expect(page).to have_title title

	end 	
end