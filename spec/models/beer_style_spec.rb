require 'spec_helper'

describe BeerStyle do
  context "with appropriate attributes" do
    subject { FactoryGirl.build(:beer_style) }

    it "should be valid" do
      subject.should be_valid
    end
  end

  it "should require name" do
    style = FactoryGirl.build(:beer_style, :name => "").should have(1).errors_on(:name)
  end

  it "should require unique name" do
    FactoryGirl.create(:beer_style, :name => "not_unique").should be_valid
    FactoryGirl.build(:beer_style, :name => "not_unique").should have(1).errors_on(:name)
  end

  it "should require a description" do
    FactoryGirl.build(:beer_style, :description => "").should have(1).errors_on(:description)
  end

  it "should require a category" do
    FactoryGirl.build(:beer_style, :category => "").should have(1).errors_on(:category)
  end

  it "should require min original gravity to be in proper range" do
    FactoryGirl.build(:beer_style, :min_orig_grav => 0.0000).should have(1).errors_on(:min_orig_grav)
    FactoryGirl.build(:beer_style, :min_orig_grav => 4.1).should have(1).errors_on(:min_orig_grav)
    FactoryGirl.build(:beer_style, :min_orig_grav => 1.012).should be_valid
  end

  it "should require max original gravity to be in proper range" do
    FactoryGirl.build(:beer_style, :max_orig_grav => 0.0000).should have(1).errors_on(:max_orig_grav)
    FactoryGirl.build(:beer_style, :max_orig_grav => 4.1).should have(1).errors_on(:max_orig_grav)
    FactoryGirl.build(:beer_style, :max_orig_grav => 1.012).should be_valid
  end

  it "should require min final gravity to be in proper range" do
    FactoryGirl.build(:beer_style, :min_final_grav => 0.0000).should have(1).errors_on(:min_final_grav)
    FactoryGirl.build(:beer_style, :min_final_grav => 4.1).should have(1).errors_on(:min_final_grav)
    FactoryGirl.build(:beer_style, :min_final_grav => 1.012).should be_valid
  end

  it "should require max final gravity to be in proper range" do
    FactoryGirl.build(:beer_style, :max_final_grav => 0.0000).should have(1).errors_on(:max_final_grav)
    FactoryGirl.build(:beer_style, :max_final_grav => 4.1).should have(1).errors_on(:max_final_grav)
    FactoryGirl.build(:beer_style, :max_final_grav => 1.012).should be_valid
  end

  it "should have recipes" do
    style = FactoryGirl.create(:beer_style)
    style.recipes << FactoryGirl.create(:recipe)
    style.recipes << FactoryGirl.create(:recipe, :name => "another recipe")
    style.recipes.count.should eq 2
  end
end

