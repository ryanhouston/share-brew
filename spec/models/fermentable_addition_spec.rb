require 'rails_helper'

describe FermentableAddition do
  it { is_expected.to belong_to :recipe }
  it { is_expected.to belong_to :fermentable }

  it { is_expected.to validate_presence_of :recipe_id }
  it { is_expected.to validate_presence_of :fermentable_id }
  it { is_expected.to validate_presence_of :weight }

  context "with color and weight" do
    subject do
      addition = FermentableAddition.new({ weight: 2.0 })
      addition.fermentable = FactoryGirl.build(:fermentable, color: 6.0)

      addition
    end

    its(:malt_color_units) { should == 12.0 }
    it "aliases #MCUs to #malt_color_units" do
      expect(subject.MCUs).to eq(subject.malt_color_units)
    end
  end
end

