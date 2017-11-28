require "rails_helper"

RSpec.feature "Users can view Projects" do 
	scenario "with the project details" do
		# ** project factory is created in the factories .spec/folder	
		
		# ** arrange
		project = FactoryGirl.create(:project, name: "Sublime Text 3")

		# ** act
		visit "/"		
		click_link "Sublime Text 3"
		
		# ** assert
		expect(page.current_url).to eq project_url(project) 
	
	end
end