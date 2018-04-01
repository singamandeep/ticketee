require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	let(:user) { FactoryGirl.create(:user) }
	let(:project) { Project.create!(name: "Ticketee") }
	let(:state) { State.create!(name: "Hacked") }
	let(:ticket) do
		project.tickets.create(name: "State transitions", description: "Can't be hacked.", author: user)
	end

	context "a user without permission to set state" do
		before do
			assign_role!(user, :editor, project)
			# without stubbing - now using devise helper methods which have been included.
			# Since, we need to check the role of the user in the policy class so we need to sign_in
			# so we sign_in inplace of stubbing.
			sign_in(user)
		end

		it "cannot transition a state by passing through state_id" do
			post :create, { comment: { text: "Did I hack it??", state_id: state.id}, ticket_id: ticket.id}
			ticket.reload
			expect(ticket.state).to be_nil
		end
	end
end
