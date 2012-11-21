require 'spec_helper'
require 'beer_science/color_calculator'

module BeerScience
  describe ColorCalculator do
    subject do
      additions = Array.new

      fa =  FermentableAddition.new({ weight: 10 })
      fa.fermentable = FactoryGirl.build(:fermentable, color: 5)
      additions << fa

      fa =  FermentableAddition.new({ weight: 2 })
      fa.fermentable = FactoryGirl.build(:fermentable, color: 20)
      additions << fa

      malt_bill = MaltBill.new({
        batch_size: 5.5,
        mash_efficiency: 0.68,
        fermentables: additions
      })
      ColorCalculator.new malt_bill
    end

    its (:total_MCUs) { should be == 90 }
    its (:MCUs_per_gallon) { should be == 16.4 }
    its (:SRM) { should == 10.3 }
  end
end

