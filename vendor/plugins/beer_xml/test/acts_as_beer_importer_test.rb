require 'test_helper'

class BeerStyle < ActiveRecord::Base
  acts_as_beer_importer :styles
end

class UnusualBeerStyle < ActiveRecord::Base
  load_schema

  acts_as_beer_importer :styles, :translated_as => {
    :abv_max => :max_abv }
end

class BeerXml::ActsAsBeerImporterTest < ActiveSupport::TestCase
  context "A BeerStyle" do
    should "have an importer type of 'style'" do
      assert_equal :styles, BeerStyle.beer_importer_type
    end

    should "be importable from a BeerXml file" do
      beer_styles = BeerStyle.import_beer_xml load_file
      assert_instance_of Array, beer_styles
      assert_instance_of BeerStyle, beer_styles.first
      assert_nil beer_styles.first.attr_map
      assert_equal 'American Amber Ale', beer_styles.first.name
      assert_equal 'American Ale', beer_styles.first.category
    end

    should "be able to specify attribute mappings" do
     beer_styles = UnusualBeerStyle.import_beer_xml load_file
     puts beer_styles.first.inspect
     assert_equal 6.0, beer_styles.first.max_abv
    end
  end

  def load_file
    filename = Rails.root.to_s + '/vendor/plugins/beer_xml/test/beer_styles.xml'
  end

end
