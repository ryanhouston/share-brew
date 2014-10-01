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
    its(:boil_off_gallons_per_hour) { should == 1.0 }
    its(:preboil_volume_gallons) { should == 7.00 }

    context "with no mash ratio specified" do
      it "provides the mash ratio" do
        subject.mash_ratio.round(4).should == 1.5036
      end

      it "provides the suggested mash ratio if none is provided" do
        subject.mash_ratio.should == subject.suggested_mash_ratio
      end
    end

    context "with a specified mash ratio" do
      let (:specified_mash_ratio_quarts_per_pound) { 1.25 }
      let (:mash_water_volume) { specified_mash_ratio_quarts_per_pound * total_grain_weight }
      subject do
        calc = MashCalculator.new(total_grain_weight, batch_size, boil_length)
        calc.mash_ratio = specified_mash_ratio_quarts_per_pound
        calc
      end

      its (:mash_ratio) { should == specified_mash_ratio_quarts_per_pound }
      its (:required_mash_water_volume_in_quarts) { should == mash_water_volume }
      its (:sparge_water_volume_gallons) { should == 3.5625 }
    end
  end
end

