require 'rails_helper'

describe Recipe do
  it { is_expected.to belong_to(:beer_style) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:fermentable_additions) }
  it { is_expected.to have_many(:hop_additions) }
  it { is_expected.to have_many(:yeast_additions) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:batch_size) }
  it { is_expected.to validate_inclusion_of(:mash_type).in_array(%w(extract grain partial)) }
  it { is_expected.to validate_presence_of(:boil_length) }
  # The following fails with Ruby 2.4
  # Known issue: https://github.com/thoughtbot/shoulda-matchers/issues/986
  # it { should validate_numericality_of(:mash_efficiency) }
  it { is_expected.to validate_inclusion_of(:boil_length).in_array((1..300).to_a) }

  context "an all grain recipe" do
    subject { FactoryGirl.build :recipe, mash_type: 'grain', mash_efficiency: 68 }

    it { is_expected.to validate_presence_of(:mash_efficiency) }
    it "detemines if the recipe is an all grain recipe" do
      expect(subject.all_grain?).to be_truthy
    end

    it "uses the given mash efficiency value in the malt bill" do
      expect(subject.malt_bill.mash_efficiency).to eq(68)
    end
  end

  context "an extract recipe" do
    subject { FactoryGirl.build :recipe, mash_type: 'extract' }

    it { is_expected.not_to validate_presence_of(:mash_efficiency) }
    it "correctly assesses a extract recipe is not all grain" do
      expect(subject.all_grain?).to be_falsey
    end

    it "uses an assumed mash efficiency value for the malt bill" do
      expect(subject.malt_bill.mash_efficiency).to eq(100)
    end
  end

  context "when adding fermentable additions" do
    subject do
      recipe = FactoryGirl.create :recipe
      @fermentable = FactoryGirl.create :fermentable
      recipe.add_fermentable({ fermentable_id: @fermentable.id, weight: 4.0 })
      recipe.fermentable_additions
    end

    its("first.fermentable_id") { should == @fermentable.id }

  end

  context "triggering a success callback after create" do
    subject { FactoryGirl.create :recipe }
    before do
      @success_called = nil
      @failure_called = nil
      @fermentable = FactoryGirl.create :fermentable
    end

    def successfully_created(fermentable_addition)
      @success_called = fermentable_addition
    end

    def failed_creation(fermentable_addition)
      @failure_called = fermentable_addition
    end

    it "calls success callback if valid new fermentable addition" do
      subject.add_fermentable(
        { fermentable_id: @fermentable.id, weight: 4.0},
        success: method(:successfully_created),
        failure: method(:failed_creation))

      expect(@success_called).to be_kind_of FermentableAddition
    end

    it "calls failure callback if invalid new fermentable addition" do
      subject.add_fermentable(
        { fermentable_id: @fermentable.id },
        success: method(:successfully_created),
        failure: method(:failed_creation))

      expect(@failure_called).to be_kind_of FermentableAddition
      expect(@failure_called.valid?).to be_falsey
    end
  end

  context "adds new ingredients" do
    subject { FactoryGirl.create :recipe }
    it "adds new hops" do
      hop = FactoryGirl.create :hop
      subject.add_hop({
        hop_id: hop.id, weight: 1.0, alpha_acid: 4.5,
        form: 'pellet', duration: 60, use: 'bittering'})

      expect(subject.hop_additions.first.hop_id).to eq(hop.id)
    end

    it "adds new yeasts" do
      yeast = FactoryGirl.create :yeast
      subject.add_yeast({ yeast_id: yeast.id })

      expect(subject.yeast_additions.first.yeast_id).to eq(yeast.id)
    end
  end

end

