class ListPolicy < ApplicationPolicy

  def index?
    user.present? && (record.user == user)
  end

  def show?
    index?
  end

  def destroy?
    index?
  end

end