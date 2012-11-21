require 'spec_helper'

describe FermentableAddition do
  it { should belong_to :recipe }
  it { should belong_to :fermentable }

  it { should validate_presence_of :recipe_id }
  it { should validate_presence_of :fermentable_id }
  it { should validate_presence_of :weight }

  context "with color and weight" do
    subject do
      addition = FermentableAddition.new({ weight: 2.0 })
      addition.fermentable = FactoryGirl.build(:fermentable, color: 6.0)

      addition
    end

    its(:MCUs) { should == 12.0 }
  end
end

