require 'test_helper'

class BeerXml::ImporterTest < ActiveSupport::TestCase

  context "Without providing XML, A BeerXml Importer" do
    setup do
      @importer = BeerXml::Importer.new
    end

    should "be a valid Importer" do
      assert_instance_of BeerXml::Importer, @importer
    end

    should "throw exception an ArgumentException when accessing reader" do
      assert_raise(BeerXml::UninitializedReaderError) do
        reader = @importer.reader
      end
    end
  end

  context "A BeerXml Importer with a valid XML file provided" do
    setup do
      @importer = BeerXml::Importer.new
      @importer.import(load_file)
    end

    should "provide a valid reader" do
      reader = @importer.reader
      assert_instance_of BeerXml::Reader, reader
    end

    should "be able to import (ShareBrew)BeerStyle objects" do
      beer_styles = @importer.styles BeerStyle
      assert_instance_of Array, beer_styles
      assert_instance_of BeerStyle, beer_styles.first
      assert_equal 'American Amber Ale', beer_styles.first.name
      assert_equal 'American Ale - 10B', beer_styles.first.category
    end

    should "be and to reset its values to a clean state" do
      @importer.reset_importer
      assert_raise BeerXml::UninitializedReaderError do
        reader = @importer.reader
      end
      assert_raise BeerXml::UninitializedReaderError do
        styles = @importer.styles BeerStyle
      end
    end
  end

  def load_file
    filename = Rails.root.to_s + '/test/fixtures/beer_styles.xml'
  end

end