require "rails_helper"

RSpec.feature "" do
	let!(:user) { FactoryGirl.create(:user) }

	# ** and here comes WARDEN!
	before do
		login_as(user)
	end

	scenario "" do
		visit "/"
		click_link "Sign out"
		expect(page).to have_content("Signed out successfully")
	end
end