class CommentPolicy < ApplicationPolicy
  def create?
    user.present? # only logged in users can comment
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end
end
