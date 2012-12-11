require 'spec_helper'
require 'beer_science/mash_calculator'

module BeerScience
  describe MashCalculator do
    let (:batch_size) { 5.5 }
    let (:total_grain_weight) { 11 }
    subject { MashCalculator.new(total_grain_weight, batch_size) }

    it "provides a suggested mash ratio" do
      subject.suggested_mash_ratio.round(2).should == 1.58
    end

    it "provides the volume of water required for the mash in quarts" do
      subject.required_mash_water_volume_in_quarts.round(2).should == 17.37
    end

    it "provides the volume of water required for the mash in gallons" do
      subject.required_mash_water_volume_in_gallons.round(2).should == 4.34
    end
  end
end

