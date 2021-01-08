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
    mine?
  end

  def destroy?
    mine?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
