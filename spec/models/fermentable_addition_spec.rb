require 'spec_helper'

describe FermentableAddition do
  it { should belong_to :recipe }
  it { should belong_to :fermentable }

  it { should validate_presence_of :recipe_id }
  it { should validate_presence_of :fermentable_id }
  it { should validate_presence_of :weight }

  describe "malt bill calculations" do
    subject do
      fermentable_addition = FermentableAddition.new
      fermentable_addition.weight = 10
      fermentable_addition.fermentable = FactoryGirl.build(
        :fermentable, potential: 1.038)

      fermentable_addition
    end

    # 10 lbs * 38 GUs * 0.68 mash efficiency
    it "calculates gravity units in relation to the recipe" do
      sprintf('%5.2f', subject.gravity_units).should == "258.40"
    end

    its (:mash_efficiency)  { should == 0.68 }
  end
end

