require 'test_helper'

class BeerStyleTest < ActiveSupport::TestCase
  context "The BeerStyle class" do
    should "act as a beer style importer" do
      assert_respond_to BeerStyle, :acts_as_beer_importer_of
      assert_respond_to BeerStyle, :import_beer_xml
    end

    should "be able to import a list of BeerXML style" do
      styles = BeerStyle.import_beer_xml load_styles_xml
      assert_instance_of Array, styles
      assert_instance_of BeerStyle, styles.first
      assert_equal styles.first.min_abv, 4.5
      assert_equal styles.first.max_abv, 6.0
      assert_equal styles.first.category, "American Ale - 10B"
      assert_equal styles.first.name, "American Amber Ale"
    end
  end

  def load_styles_xml
    filename = Rails.root + 'test/fixtures/bjcp-2008-styles.xml'
  end

end
