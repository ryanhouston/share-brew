class Ingredient < ActiveRecord::Base
    has_many :recipes, :through => :recipe_ingredients

    validates_presence_of :name, :description
    validates_inclusion_of :ingredient_type, :in => %w(malt hops yeast other),
        :message => "%{value} is not a valid ingredient type"
end
