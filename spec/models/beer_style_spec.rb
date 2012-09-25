require 'spec_helper'

describe BeerStyle do
  context "with appropriate attributes" do
    subject { FactoryGirl.build(:beer_style) }
    it { should be_valid }
  end

  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :category }
  it { should ensure_inclusion_of(:min_orig_grav).in_range(0.0001..4.0001) }
  it { should ensure_inclusion_of(:max_orig_grav).in_range(0.0001..4.0001) }
  it { should ensure_inclusion_of(:min_final_grav).in_range(0.0001..4.0001) }
  it { should ensure_inclusion_of(:max_final_grav).in_range(0.0001..4.0001) }
  it { should have_many(:recipes) }

  context "The BeerSTyle class" do
    it "acts as a BeerXml importer" do
      BeerStyle.should respond_to(:acts_as_beer_importer_of)
      BeerStyle.should respond_to(:import_beer_xml)
    end

    it "can import a list of BeerXML style" do
      styles = BeerStyle.import_beer_xml( load_styles_xml )
      styles.should be_kind_of(Array)
      styles.first.should be_kind_of(BeerStyle)
      styles.first.min_abv.should eq 4.5
      styles.first.max_abv.should eq 6.0
      styles.first.category.should eq "American Ale - 10B"
      styles.first.name.should eq "American Amber Ale"
    end
  end

  def load_styles_xml
    filename = Rails.root + 'test/fixtures/bjcp-2008-styles.xml'
  end
end

