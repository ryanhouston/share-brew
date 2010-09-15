require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  should have_many(:recipes).through(:recipe_ingredients)

  should validate_presence_of :name
  should validate_presence_of :description

  %w(malt hops yeast other).each { |type|
    should allow_value(type).for(:ingredient_type)
  }

end
