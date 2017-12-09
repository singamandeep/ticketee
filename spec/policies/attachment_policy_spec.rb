require 'rails_helper'

RSpec.describe AttachmentPolicy do
  context "permissions" do
    subject { AttachmentPolicy.new(user, attachment) } # ** this is the syntax of the Pundit gem when using the 
    # ** reduced RSpec syntax, see Pundit gem.

    let(:user) { FactoryGirl.create(:user) }
    let(:author) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let(:ticket) { FactoryGirl.create(:ticket, project: project, author: author) }
    let(:attachment) { FactoryGirl.create(:attachment, ticket: ticket) }

    context "for anonymous users" do
      let(:user) { nil }

      it { should_not permit_action :show}
    end

    context "for viewers of the project" do
      before { assign_role!(user, :viewer, project) }

      it { should permit_action :show}
    end

    context "for editors of the project" do
      before { assign_role!(user, :editor, project) }

      it { should permit_action :show}
    end

    context "for managers of the project" do
      before { assign_role!(user, :manager, project) }

      it { should permit_action :show}
    end

    context "for managers of other projects" do
      before do
        other_project = FactoryGirl.create(:project)
        assign_role!(user, :manager, other_project)
      end

      it { should_not permit_action :show}
    end

    context "for administrators" do
      let(:user) { FactoryGirl.create(:user, :admin) }

      it { should permit_action :show}   
    end

  end
end
