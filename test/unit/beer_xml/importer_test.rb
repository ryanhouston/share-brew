require 'test_helper'

class BeerXml::ImporterTest < ActiveSupport::TestCase

  context "Without providing XML, A BeerXml Importer" do
    setup do
      @importer = BeerXml::Importer.new
    end

    should "be a valid Importer" do
      assert_instance_of BeerXml::Importer, @importer
    end

    should "throw exception when accessing reader" do
      assert_raise(BeerXml::UninitializedReaderError) do
        reader = @importer.reader
      end
    end
  end

  context "A BeerXml Importer with a valid XML file provided" do
    setup do
      xml_filename = Rails.root.to_s + '/test/unit/beer_xml/beer_styles.xml'
      xml_file = File.new(xml_filename)
      @importer = BeerXml::Importer.new(xml_file)
    end

    should "provide a valid reader" do
      reader = @importer.reader
      assert_instance_of BeerXml::Reader, reader
    end

    should "be able to import (ShareBrew)BeerStyle objects" do
      beer_styles = @importer.styles
      assert_instance_of Array, beer_styles
      assert_instance_of BeerStyle, beer_styles.first
      assert_equal 'American Amber Ale', beer_styles.first.name
      assert_equal 'American Ale', beer_styles.first.category
    end

  end

end
