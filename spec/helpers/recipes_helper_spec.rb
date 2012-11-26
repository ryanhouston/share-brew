require 'spec_helper'
require 'recipes_helper'

describe RecipesHelper do
  it "returns 'N/A' when given a blank gravity" do
    format_gravity('').should == 'N/A'
  end

  it "pads with 0s to get 3 levels of precision" do
    format_gravity(1.01).should == '1.010'
  end

  it "does nothing when given a properly formatted gravity" do
    format_gravity(1.011).should == '1.011'
  end

  it "responds properly when given a string" do
    format_gravity('1.01').should == '1.010'
  end
end

