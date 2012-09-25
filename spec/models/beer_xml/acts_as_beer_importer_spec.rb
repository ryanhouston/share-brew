require 'spec_helper'
require 'beer_xml'

class MockBeerStyle
  include BeerXml
  acts_as_beer_importer_of :styles
end

describe BeerXml do
  context "The MockBeerStyle class" do
    subject { MockBeerStyle }
    its( :beer_importer_type ) { should eq :styles }
  end

  context "a collection of MockBeerStyles imported from a beer xml file" do
    subject { @styles = MockBeerStyle.import_beer_xml(load_file) }
  end
end

