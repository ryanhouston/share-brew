require 'spec_helper'
require 'recipe_profile'

describe RecipeProfile do
  context "a recipe without any ingredients" do
    subject { RecipeProfile.new(FactoryGirl.build(:recipe)) }
    its (:calculated_starting_gravity) { should == 1.0 }
    its (:calculated_final_gravity) { should == 1.0 }
    its (:IBUs) { should be 0 }
    its (:bitterness_ratio) { should be 0 }
  end

  context "recipe with yeast additions" do
    subject do
      recipe = FactoryGirl.build(:recipe)
      yeast_addition = YeastAddition.new
      yeast_addition.yeast = FactoryGirl.build(:yeast,
        strain: 'mega yeast',
        attenuation: '0.75'
      )
      recipe.yeast_additions << yeast_addition

      RecipeProfile.new(recipe)
    end

    its(:attenuation) { should == 0.75 }
  end
end

