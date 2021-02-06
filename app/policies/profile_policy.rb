# frozen_string_literal: true

# profile policy class
class ProfilePolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    true
  end

  def create?
    @user.present?
  end

  def update?
    me? || admin?
  end

  def destroy?
    me? || admin?
  end

  private

  def me?
    @record == @profile
  end

  # scope
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
