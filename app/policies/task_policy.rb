class TaskPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def show?
    index?
  end

  def destroy?
    index?
  end

end