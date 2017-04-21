require 'rails_helper'
require 'beer_science/abv_calculator'

module BeerScience
  describe ABVCalculator do
    it "provides the alcohol by volume given original and final gravities" do
      expect(ABVCalculator.calculate(1.068, 1.012).round(2)).to eq(7.68)
    end
  end
end

