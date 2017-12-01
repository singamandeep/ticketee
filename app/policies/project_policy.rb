class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
    # ** this is begin called from the index action 
    # ** of the ProjectController
      return scope.none if user.nil?
      return scope.all if user.admin?

    # ** SQL based join query
    # ** although we have passed the complete user here in place of id
    # ** rails automatically sets the id in the query, we would have
    # ** passed id as user.try(:id) to prevent user from being nil
    # ** were as in the previous case this is handled automatically
      scope.joins(:roles).where(roles: {user_id: user})
    end
  end

  def show?
  	user.try(:admin?) || record.roles.exists?(user_id: user)
  end

  def update?
    user.try(:admin?) || record.roles.exists?(user_id: user, role: 'manager')
  end
end
