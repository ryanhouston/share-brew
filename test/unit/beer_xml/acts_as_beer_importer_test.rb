require 'test_helper'
require 'beer_xml'

class BeerStyle < ActiveRecord::Base
  acts_as_beer_importer_of :styles
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

class BeerXml::ActsAsBeerImporterTest < ActiveSupport::TestCase
  context "A BeerStyle" do
    should "be importable from a BeerXml file" do
      beer_styles = BeerStyle.import_beer_xml load_file
      assert_instance_of Array, beer_styles
      assert_instance_of BeerStyle, beer_styles.first
    end

    should "import values for like named attributes" do
      beer_styles = BeerStyle.import_beer_xml load_file
      assert_equal 'American Amber Ale', beer_styles.first.name
      assert_equal 'American Ale - 10B', beer_styles.first.category
    end
  end

  context "A BeerStyle imported from BeerXML" do
    setup do
      beer_styles = UnusualBeerStyle.import_beer_xml(load_file)
      @first_style = beer_styles.first
      assert_instance_of Array, beer_styles
    end

    should "be able to map a beer XML property to another attribute name" do
      assert_equal "6.00", @first_style.max_abv
      assert_equal "4.50", @first_style.min_abv
    end

    should "be able to define a method for importing a specified attribute" do
      assert_match /caramel richness/, @first_style.description
      assert_match /chocolate or roast character/, @first_style.description
      assert_match /citrusy flavors/, @first_style.description
      assert_match /Rogue Red Ale/, @first_style.description
    end
  end

  def load_file
    filename = Rails.root.to_s + '/test/fixtures/beer_styles.xml'
  end

end
