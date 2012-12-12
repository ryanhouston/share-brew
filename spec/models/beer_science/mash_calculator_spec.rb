require 'spec_helper'
require 'beer_science/mash_calculator'

module BeerScience
  describe MashCalculator do
    let (:batch_size) { 5.5 }
    let (:total_grain_weight) { 11 }
    let (:boil_length) { 90 }

    subject { MashCalculator.new(total_grain_weight, batch_size, boil_length) }

    it "provides the volume of water required for the mash in quarts" do
      subject.required_mash_water_volume_in_quarts.round(2).should == 16.54
    end

    it "provides the volume of water required for the mash in gallons" do
      subject.required_mash_water_volume_in_gallons.round(2).should == 4.13
    end

    its(:boil_off_gallons) { should == 1.50 }
    its(:preboil_volume_gallons) { should == 7.00 }

    context "with no mash ratio specified" do
      its (:mash_ratio) { subject.round(4).should == 1.5036 }
      it "provides the suggested mash ratio if none is provided" do
        subject.mash_ratio.should == subject.suggested_mash_ratio
      end
    end

    context "with a specified mash ratio" do
      subject do
        calc = MashCalculator.new(total_grain_weight, batch_size, boil_length)
        calc.mash_ratio = 1.25
        calc
      end

      it "uses the specified mash ratio instead of suggested" do
        subject.mash_ratio.should == 1.25
      end
    end
  end
end

