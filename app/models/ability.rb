# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Article, public: true

    if user.persisted?
      can :read, Comment, public: true
      can :create, Comment
      can :update, Comment, user_id: user.id
      can :destroy, Comment, user_id: user.id
    end

    can :manage, :all if user.role == "admin"

  end
end
