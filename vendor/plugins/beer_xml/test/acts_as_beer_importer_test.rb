require 'test_helper'

class BeerStyle < ActiveRecord::Base
  acts_as_beer_importer :styles
end

class BeerXml::ActsAsTest < ActiveSupport::TestCase
  context "A BeerStyle" do
    should "have an importer type of 'style'" do
      assert_equal :styles, BeerStyle.beer_importer_type
    end

    should "can be imported from a BeerXml file" do
      beer_styles = BeerStyle.import_beer_xml load_file
      assert_instance_of Array, beer_styles
      assert_instance_of BeerStyle, beer_styles.first
      assert_equal 'American Amber Ale', beer_styles.first.name
      assert_equal 'American Ale', beer_styles.first.category
    end
  end

  def load_file
    filename = Rails.root.to_s + '/vendor/plugins/beer_xml/test/beer_styles.xml'
  end

end
