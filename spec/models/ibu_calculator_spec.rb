require 'spec_helper'
require 'beer_science/ibu_calculator'

module BeerScience
  describe IBUCalculator do
    it "calculates IBUs given hop addition details" do
      subject.IBUs_for_addition(
        weight: 3.0,
        alpha_acid: 4.4,
        boil_time: 60,
        boil_gravity: 1.060,
        batch_size: 5.5
      ).round(2).should == 37.95
    end

    it "calculates AAUs given a weight and alpha acid %" do
      subject.AAUs_for_addition(2.0, 4.4).should == 8.8
    end

    it "provides the hop utilization rate for the boil" do
      subject.hop_utilization(1.060, 60).round(3).should == 0.211
    end
  end
end

