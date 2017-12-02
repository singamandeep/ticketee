require 'rails_helper'

RSpec.describe ProjectPolicy do
#  subject { described_class }
  
  # ** test to - hide links from the index of the ProjectController
  # ** it has been implemented on the scope in ProjectPolicy class.
  context "policy_scope" do

    # ** this subject has similar meaning as in the index of the prroject controller
    subject { Pundit.policy_scope(user, Project) }

    let!(:project) { FactoryGirl.create(:project) }
    let(:user) { FactoryGirl.create(:user) }

    it "is empty for anonymous users" do
      expect(Pundit.policy_scope(nil, Project)).to be_empty
    end

    it "includes projects a user is allowed to view" do
      assign_role!(user, :viewer, project)
      expect(subject).to include(project)
    end

    it "doesn't include projects a user is not allowed to view" do
      expect(subject).to be_empty
    end

    it "returns all projects for admins" do
      user.admin = true
      expect(subject).to include(project)
    end

  end

  context "permissions" do
    subject { ProjectPolicy.new(user, project) } # ** this is the syntax of the Pundit gem when using the 
    # ** reduced RSpec syntax, see Pundit gem.

    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }

    context "for anonymous users" do
      let(:user) { nil }

      it { should_not permit_action :show}
      it { should_not permit_action :update}
    end

    context "for viewers of the project" do
      before { assign_role!(user, :viewer, project) }

      it { should permit_action :show}
      it { should_not permit_action :update}
    end

    context "for editors of the project" do
      before { assign_role!(user, :editor, project) }

      it { should permit_action :show}
      it { should_not permit_action :update}    
    end

    context "for managers of the project" do
      before { assign_role!(user, :manager, project) }

      it { should permit_action :show}
      it { should permit_action :update}    
    end

    context "for managers of other projects" do
      before do
        other_project = FactoryGirl.create(:project)
        assign_role!(user, :manager, other_project)
      end

      it { should_not permit_action :show}
      it { should_not permit_action :update}    
    end

    context "for administrators" do
      let(:user) { FactoryGirl.create(:user, :admin) }

      it { should permit_action :show}
      it { should permit_action :update}    
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
