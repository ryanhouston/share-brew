require 'spec_helper'

describe Recipe do
  it { should belong_to(:beer_style) }
  it { should belong_to(:user) }
  it { should have_many(:fermentable_additions) }
  it { should have_many(:hop_additions) }
  it { should have_many(:yeast_additions) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:batch_size) }
  it { should validate_presence_of(:description) }
  it { should ensure_inclusion_of(:mash_type).in_array(%w(extract grain partial)) }

  context "a Recipe without any ingredients" do
    subject { FactoryGirl.create :recipe }

    it "adds fermentables to itself" do
      fermentable = FactoryGirl.create :fermentable
      subject.add_fermentable({ fermentable_id: fermentable.id, weight: 4.0 })

      subject.fermentable_additions.first.fermentable_id.should == fermentable.id
    end
  end
end

