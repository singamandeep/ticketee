require 'rails_helper'

RSpec.feature "Admin can manage states" do
	let!(:state) { FactoryGirl.create(:state, name: "New") }
	let(:user) { FactoryGirl.create(:user, :admin) }
	before do
		login_as(user)
		visit admin_states_path
	end

	scenario "and mark a state as default" do
		within row_cell_item("New") do
			click_link "Make Default"
		end

		expect(page).to have_content "'New' is now the default state."
	end
end