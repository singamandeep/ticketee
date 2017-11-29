require "rails_helper"

RSpec.feature "User can view tickets" do
	scenario "for a given project" do
		author = FactoryGirl.create(:user)
		# ** arrange
		sublime = FactoryGirl.create(:project, name: "Sublime Text 3")
		FactoryGirl.create(:ticket, project: sublime, name: "Make it shiny!", description: "Gradients! Starbursts! Oh my!", author: author)
		ie = FactoryGirl.create(:project, name: "Internet Explorer")
		FactoryGirl.create(:ticket, project: ie, name: "Standard Compilance", description: "Isn't a joke!", author: author)

		# ** act 
		visit '/'
		click_link "Sublime Text 3"


		# ** assert
		expect(page).to have_content "Make it shiny!"
		expect(page).to_not have_content "Standard Compilance"
		click_link "Make it shiny!"
		# ** this means on the current loaded page find a div with 
		# ** id = "ticket" and in that div find a tag h2 within 
		# ** which the content should be present.
		within('#ticket h2') do
			expect(page).to have_content "Make it shiny!"
		end
		expect(page).to have_content "Gradients! Starbursts! Oh my!"
	end
end