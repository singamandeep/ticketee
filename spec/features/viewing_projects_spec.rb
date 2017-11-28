require "rails_helper"

RSpec.feature "Users can view Projects" do 
	scenario "with the project details" do
		# ** project factory is created in the factories .spec/folder	
		project = FactoryGirl.create(:project, name: "Sublime Text 3")

		visit "/"
		
		click_link "Sublime Text 3"
		
		expect(page.current_url).to eq project_url(project) 
	
	end
end