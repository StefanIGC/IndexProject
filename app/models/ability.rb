# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # if user.persisted?
    #   can :read, Comment
    # end
    can :manage, :Comment if user.role == 'user'
    can :manage, :all if user.role == 'admin'
  end
end
