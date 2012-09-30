require 'spec_helper'

describe BeerXml::Importer do
  context "Without providing XML, A BeerXml Importer" do
    subject { BeerXml::Importer.new }

    it "should raise an error if no XML was provided" do
      expect { subject.reader }.to raise_error(BeerXml::UninitializedReaderError)
    end
  end

  context "A BeerXml Importer with a valid XML file provided" do
    subject do
      importer = BeerXml::Importer.new
      importer.import(load_file)
      importer
    end

    its( :reader ) { should be_kind_of(BeerXml::Reader) }

    it "should be able to import (ShareBrew)BeerStyle objects" do
      beer_styles = subject.styles(BeerStyle)
      beer_styles.should be_kind_of(Array)
      beer_styles.first.should be_kind_of(BeerStyle)
    end

    it "can reset its values to a clean state" do
      subject.reset_importer
      expect { subject.reader }.to raise_error(BeerXml::UninitializedReaderError)
      expect { subject.styles(BeerStyle) }.to raise_error(BeerXml::UninitializedReaderError)
    end
  end

  def load_file
    filename = Rails.root.to_s + '/test/fixtures/beer_styles.xml'
  end
end

