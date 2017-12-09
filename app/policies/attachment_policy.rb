class AttachmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  # ** all those who have access to ticket or project have the 
  # ** access to the attachment
  def show?
  	user.try(:admin?) || record.ticket.project.has_member?(user)
  end
end
