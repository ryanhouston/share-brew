require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  should belong_to :beer_style

  should have_many :recipe_ingredients
  should have_many(:ingredients).through(:recipe_ingredients)

  should validate_presence_of :name
  should validate_presence_of :batch_size
  should validate_presence_of :description
  should validate_presence_of :procedure

  %w(extract grain partial).each { |mash|
    should allow_value(mash).for(:mash_type)
  }

  context "a recipe with the wrong mash type" do
    setup do
      @recipe = Factory.build(:recipe, :mash_type => 'Peanuts')
    end

    should "not be valid" do
      assert !@recipe.valid?
    end
  end

end
