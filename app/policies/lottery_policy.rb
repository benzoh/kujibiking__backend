# frozen_string_literal: true

class LotteryPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    @user.present?
  end

  def update?
    mine? || admin?
  end

  def destroy?
    mine? || admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
