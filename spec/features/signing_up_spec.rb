require "rails_helper"

RSpec.feature "User can sign up" do
	scenario "when providing valid details" do
		# ** act
		visit "/"
		click_link "Sign up"
		fill_in "Email", with: "test@example.com"
		fill_in "user_password", with: "password"
		fill_in "Password confirmation", with: "password"
		click_button "Sign up"

		# ** assert
		expect(page).to have_content("You have signed up successfully")

	end
end