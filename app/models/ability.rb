class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Recipe
    can [:update, :destroy], Recipe, user_id: user.id
  end
end
