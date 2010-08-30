class Ingredient < ActiveRecord::Base
    has_many :recipes, :through => :recipe_ingredients

    validates_presence_of :name, :description
end
