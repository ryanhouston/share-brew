require 'spec_helper'

describe BeerStyle do
  context "with appropriate attributes" do
    subject { FactoryGirl.build(:beer_style) }
    it { should be_valid }
  end

  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :category }
  it { should ensure_inclusion_of(:min_orig_grav).in_range(0.0001..4.0001) }
  it { should ensure_inclusion_of(:max_orig_grav).in_range(0.0001..4.0001) }
  it { should ensure_inclusion_of(:min_final_grav).in_range(0.0001..4.0001) }
  it { should ensure_inclusion_of(:max_final_grav).in_range(0.0001..4.0001) }
  it { should have_many(:recipes) }
end

