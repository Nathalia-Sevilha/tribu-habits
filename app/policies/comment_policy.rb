class CommentPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    user.present?   # anyone logged in can create
  end

  def destroy?
    user.present? && (record.user_id == user.id || user.admin?)
    # only the author or admins can delete
  end

  class Scope < Scope
    def resolve
      scope.all  # or scope.where(user: user) if you want scoping
    end
  end
end
