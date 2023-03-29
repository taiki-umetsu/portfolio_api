# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.full_access?
      can :manage, :all
    else
      can :read, :all
    end
  end
end
