require 'spec_helper'
require 'beer_science/mash_calculator'

module BeerScience
  describe MashCalculator do
    let (:batch_size) { 5.5 }
    let (:total_grain_weight) { 11 }

    context "with no mash ratio specified" do
      subject { MashCalculator.new(total_grain_weight, batch_size) }

      it "provides a suggested mash ratio" do
        subject.suggested_mash_ratio.round(2).should == 1.58
      end
      its (:mash_ratio) { subject.round(2).should == 1.58 }

      it "provides the volume of water required for the mash in quarts" do
        subject.required_mash_water_volume_in_quarts.round(2).should == 17.37
      end

      it "provides the volume of water required for the mash in gallons" do
        subject.required_mash_water_volume_in_gallons.round(2).should == 4.34
      end
    end

    context "with a specified mash ratio" do
      subject do
        calc = MashCalculator.new(total_grain_weight, batch_size)
        calc.mash_ratio = 1.25
        calc
      end

      it "uses the specified mash ratio instead of suggested" do
        subject.mash_ratio.should == 1.25
      end
    end
  end
end

