class HabitPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    true
  end

  def update?
    true
  end
  
  def destroy?
    true
  end

  def preselect?
     true
  end
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
      # scope.where(user: user) # If users can only see their habits
      # scope.where("name LIKE 't%'") # If users can only see habits starting with `t`
    end
  end
end
