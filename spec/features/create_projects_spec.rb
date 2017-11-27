require 'rails_helper'

RSpec.feature "User can create new projects" do 
	scenario "with valid attributes" do
		
		visit "/"

		click_link "New Project"

		# ** here "Name" and "Description" are label names.
		fill_in "Name", with: "Sublime text 3"
		fill_in "Description", with: "A text Editor for everyone"
		click_button "Create Project"

		expect(page).to have_content "Project has been created."

	end 	
end