class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Recipe
    can [:update, :destroy], Recipe, user_id: user.id

    if user.admin?
      can [:create, :update, :destroy], BeerStyle
      can [:create, :update, :destroy], Hop
      can [:create, :update, :destroy], Fermentable
      can [:create, :update, :destroy], Yeast
    end
  end
end
