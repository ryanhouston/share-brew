class Ingredient < ActiveRecord::Base
    has_many :recipes, :through => :recipe_ingredients

    validates_presence_of :name, :description
    validates_inclusion_of :ingredient_type, :in => %w(malt hops yeast other),
        :message => "%{value} is not a valid ingredient type"

    scope :malt,  where(:ingredient_type => 'malt')
    scope :hop,   where(:ingredient_type => 'hop')
    scope :yeast, where(:ingredient_type => 'yeast')

end
