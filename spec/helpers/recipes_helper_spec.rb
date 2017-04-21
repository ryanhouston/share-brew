require 'rails_helper'
require 'recipes_helper'

describe RecipesHelper do
  it "returns 'N/A' when given a blank gravity" do
    expect(format_gravity('')).to eq('N/A')
  end

  it "pads with 0s to get 3 levels of precision" do
    expect(format_gravity(1.01)).to eq('1.010')
  end

  it "does nothing when given a properly formatted gravity" do
    expect(format_gravity(1.011)).to eq('1.011')
  end

  it "responds properly when given a string" do
    expect(format_gravity('1.01')).to eq('1.010')
  end
end

