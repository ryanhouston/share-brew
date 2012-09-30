require 'spec_helper'

describe BeerXml::Reader do
  context "Given a valid BeerXml file of beer style data, the Reader" do
    subject { BeerXml::Reader.new(load_file).styles }
    it { should be_kind_of(Array) }

    it "returns style data as a hash map" do
      subject.first.should be_kind_of(Hash)
    end
  end

  context "Given a parsed BeerXml Beer Style" do
    subject { BeerXml::Reader.new(load_file).styles.first }

    it "has a Name attribute" do
      subject['NAME'].should == 'American Amber Ale'
    end
  end

  def load_file
    beer_styles_file = Rails.root.to_s + '/spec/fixtures/beer_styles.xml'
    File.new(beer_styles_file)
  end
end

