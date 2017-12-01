require 'rails_helper'

RSpec.describe TicketPolicy do
  #subject { described_class }
  
  context "permissions" do
    subject { TicketPolicy.new(user, ticket) }

    let(:user) { FactoryGirl.create(:user) }
    let(:author) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let(:ticket) { FactoryGirl.create(:ticket, project: project, author: author) }

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


=begin
  # ** test to hide show from the ProjectController based on roles.
  permissions :show? do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }

    it "block anonymous users" do
      expect(subject).not_to permit(nil, project)
    end

    it "allows viewers of the project" do
      assign_role!(user, :viewer, project)
      expect(subject).to permit(user, project)
    end

    it "allows editors of the project" do
      assign_role!(user, :editor, project)
      expect(subject).to permit(user, project)
    end

    it "allows managers of the project" do
      assign_role!(user, :manager, project)
      expect(subject).to permit(user, project)
    end

    it "allows administrators" do
      admin = FactoryGirl.create(:user, :admin)
      expect(subject).to permit(admin, project)
    end

    it "doesn't allow users assigned to other projects" do
      other_project = FactoryGirl.create(:project)
      assign_role!(user, :manager, other_project)
      expect(subject).not_to permit(user, project)
    end  
  end

  # ** test to hide update from the ProjectController based on roles.
  permissions :update? do
    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }

    it "block anonymous users" do
      expect(subject).not_to permit(nil, project)
    end

    it "doesn't allows viewers of the project" do
      assign_role!(user, :viewer, project)
      expect(subject).not_to permit(user, project)
    end

    it "doesn't allows editors of the project" do
      assign_role!(user, :editor, project)
      expect(subject).not_to permit(user, project)
    end

    it "allows managers of the project" do
      assign_role!(user, :manager, project)
      expect(subject).to permit(user, project)
    end

    it "allows administrators" do
      admin = FactoryGirl.create(:user, :admin)
      expect(subject).to permit(admin, project)
    end

    it "doesn't allow users assigned to other projects" do
      other_project = FactoryGirl.create(:project)
      assign_role!(user, :manager, other_project)
      expect(subject).not_to permit(user, project)
    end  
  end
=end
end
