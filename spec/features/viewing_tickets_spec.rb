require "rails_helper"

RSpec.feature "User can view tickets" do

	before do
		author = FactoryGirl.create(:user)


		sublime = FactoryGirl.create(:project, name: "Sublime Text 3")
		assign_role!(author, :viewer, sublime)
		FactoryGirl.create(:ticket, project: sublime, name: "Make it shiny!", description: "Gradients! Starbursts! Oh my!", author: author)

		ie = FactoryGirl.create(:project, name: "Internet Explorer")
		assign_role!(author, :viewer, ie)
		FactoryGirl.create(:ticket, project: ie, name: "Standard Compilance", description: "Isn't a joke!", author: author)

		login_as(author)
		visit '/'
	end

	scenario "for a given project" do
		
		click_link "Sublime Text 3"


		# ** assert
		expect(page).to have_content "Make it shiny!"
		expect(page).to_not have_content "Standard Compilance"
		click_link "Make it shiny!"
		# ** this means on the current loaded page find a div with 
		# ** id = "ticket" and in that div find a tag h2 within 
		# ** which the content should be present.
		within('#ticket') do
			expect(page).to have_content "Make it shiny!"
		end
		expect(page).to have_content "Gradients! Starbursts! Oh my!"
	end
end