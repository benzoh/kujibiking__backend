# frozen_string_literal: true

#
# user policy class
#
class UserPolicy < ApplicationPolicy
  #
  # scope
  #
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
