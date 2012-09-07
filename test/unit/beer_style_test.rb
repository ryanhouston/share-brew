require 'test_helper'

class BeerStyleTest < ActiveSupport::TestCase
  context "a beer" do
    setup do
      @beer_style = FactoryGirl.build(:beer_style)
    end

    should have_many(:recipes)

    should validate_presence_of :name
  # SKIP - should work but shoulda is not filling out other required fields
    # should validate_uniqueness_of(:name).case_insensitive
    should validate_presence_of :description
    should validate_presence_of :category

    should ensure_inclusion_of(:min_orig_grav).in_range( 0.0001..4.0001)
    should ensure_inclusion_of(:max_orig_grav).in_range( 0.0001..4.0001)
    should ensure_inclusion_of(:min_final_grav).in_range( 0.0001..4.0001)
    should ensure_inclusion_of(:max_final_grav).in_range( 0.0001..4.0001)
  end

  context "a beer style without a name" do
    setup do
      @beer_style = FactoryGirl.build(:beer_style, :name => '')
    end

    should "not be valid" do
      assert !@beer_style.valid?
    end

  end

  context "A Beer Style instance" do
    setup do
      @beer_style = FactoryGirl.build(:beer_style)
    end

    ['name', 'description', 'lager', 'category', 'min_orig_grav',
       'max_orig_grav', 'min_final_grav', 'max_final_grav', 'min_IBUs',
       'max_IBUs', 'min_color', 'max_color', 'min_carbonation', 'max_carbonation', 'min_abv',
       'max_abv'].each do |attr|
      should "have a visible attribute called #{attr}" do
        assert @beer_style.respond_to? attr
      end

    end
  end

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
