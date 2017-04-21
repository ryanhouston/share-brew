require 'rails_helper'
require 'beer_xml'

describe BeerXml do
  context "The MockBeerStyle class" do
    subject { MockBeerStyle }
    its( :beer_importer_type ) { should eq :styles }
  end

  context "a collection of MockBeerStyles imported from a beer xml file" do
    subject { @styles = MockBeerStyle.import_beer_xml(load_file) }
    it { is_expected.to be_kind_of Array }
    its( :first ) { should be_kind_of MockBeerStyle }
  end

  context "An imported beer style" do
    subject { MockBeerStyle.import_beer_xml(load_file).first }
    its( :name ) { should == 'American Amber Ale' }
    its( :category ) { should == 'American Ale' }
  end

  context "A BeerStyle with custom mappings imported from BeerXML" do
    subject { UnusualBeerStyle.import_beer_xml(load_file).first }
    its( :max_abv ) { should == "6.00" }
    its( :min_abv ) { should == "4.50" }
    its( :description ) { should match(/caramel richness/) }
    its( :description ) { should match(/chocolate or roast character/) }
    its( :description ) { should match(/citrusy flavors/) }
    its( :description ) { should match(/Rogue Red Ale/) }
  end

  def load_file
    Rails.root.to_s + '/spec/fixtures/beer_styles.xml'
  end
end

class MockBeerStyle
  include BeerXml
  attr_accessor :name, :category, :max_abv, :min_abv, :description
  acts_as_beer_importer_of :styles

  def logger
    @logger ||= NullLogger.new
  end

  class NullLogger
    def debug( msg ); end
  end
end

class UnusualBeerStyle
  include BeerXml

  attr_accessor :max_abv, :min_abv, :description

  acts_as_beer_importer_of(:styles).translated_as({
    :abv_max => :max_abv, :abv_min => :min_abv,
  }).using({
    :description => :compose_description,
  });


  def compose_description beer_attrs
    desc = beer_attrs["NOTES"] + "\n\n" +
      beer_attrs["PROFILE"] + "\n\n" +
      beer_attrs["INGREDIENTS"] + "\n\n" +
      beer_attrs["EXAMPLES"]

    description = desc
  end

  def logger
    @logger ||= NullLogger.new
  end

  class NullLogger
    def debug( msg )
    end
  end
end

