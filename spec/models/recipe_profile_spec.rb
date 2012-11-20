require 'spec_helper'
require 'recipe_profile'

describe RecipeProfile do
  subject { RecipeProfile.new(FactoryGirl.build(:recipe)) }
  its (:calculated_starting_gravity) { should == 1.0 }
  its (:IBUs) { should be 0 }
end

