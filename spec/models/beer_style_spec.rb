require 'rails_helper'

describe BeerStyle do
  context "with appropriate attributes" do
    subject { FactoryGirl.build(:beer_style) }
    it { is_expected.to be_valid }
  end

  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to validate_inclusion_of(:min_orig_grav).in_range(0.0001..4.0001) }
  it { is_expected.to validate_inclusion_of(:max_orig_grav).in_range(0.0001..4.0001) }
  it { is_expected.to validate_inclusion_of(:min_final_grav).in_range(0.0001..4.0001) }
  it { is_expected.to validate_inclusion_of(:max_final_grav).in_range(0.0001..4.0001) }
  it { is_expected.to have_many(:recipes) }

  context "The BeerSTyle class" do
    it "acts as a BeerXml importer" do
      expect(BeerStyle).to respond_to(:acts_as_beer_importer_of)
      expect(BeerStyle).to respond_to(:import_beer_xml)
    end

    it "can import a list of BeerXML style" do
      styles = BeerStyle.import_beer_xml( load_styles_xml )
      expect(styles).to be_kind_of(Array)
      expect(styles.first).to be_kind_of(BeerStyle)
      expect(styles.first.min_abv).to eq 4.5
      expect(styles.first.max_abv).to eq 6.0
      expect(styles.first.category).to eq "American Ale"
      expect(styles.first.style_id).to eq '10B'
      expect(styles.first.name).to eq "American Amber Ale"
    end
  end

  def load_styles_xml
    filename = Rails.root + 'spec/fixtures/bjcp-2008-styles.xml'
  end
end

