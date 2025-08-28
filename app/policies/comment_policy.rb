class CommentPolicy < ApplicationPolicy
  def new?    = create?
  def create? = user.present?
  def destroy?
    user.present? && (record.user_id == user.id || user.respond_to?(:admin?) && user.admin?)
  end
end
