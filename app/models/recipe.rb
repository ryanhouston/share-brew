class Recipe < ActiveRecord::Base
    belongs_to :beer_style
    belongs_to :user
    has_many :recipe_ingredients
    has_many :ingredients, :through => :recipe_ingredients

    validates_presence_of :name, :batch_size, :description, :procedure
    validates_inclusion_of :mash_type, :in => ['extract', 'grain', 'partial']

    accepts_nested_attributes_for :recipe_ingredients

    def malts
      recipe_ingredients.joins(:ingredient).where('ingredients.ingredient_type = "malt"')
    end

    def hops
      recipe_ingredients.joins(:ingredient).where('ingredients.ingredient_type = "hops"')
    end

    def yeast
      recipe_ingredients.joins(:ingredient).where('ingredients.ingredient_type = "yeast"')
    end

end
