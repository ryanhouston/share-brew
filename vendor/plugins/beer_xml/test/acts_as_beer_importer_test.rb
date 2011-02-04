require 'test_helper'

class BeerStyle < ActiveRecord::Base
  acts_as_beer_importer_of :styles
end

class UnusualBeerStyle < ActiveRecord::Base
  load_schema

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

    write_attribute :description, desc
  end
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
    end

    should "import values for like named attributes" do
      beer_styles = BeerStyle.import_beer_xml load_file
      assert_equal 'American Amber Ale', beer_styles.first.name
      assert_equal 'American Ale', beer_styles.first.category
    end
  end

  context "A BeerStyle imported from BeerXML" do
    setup do
      beer_styles = UnusualBeerStyle.import_beer_xml(load_file)
      @first_style = beer_styles.first
      assert_instance_of Array, beer_styles
    end

    should "be able to map a beer XML property to another attribute name" do
      assert_equal 6.0, @first_style.max_abv
      assert_equal 4.5, @first_style.min_abv
    end

    should "be able to define a method for importing a specified attribute" do
      assert_match /caramel richness/, @first_style.description
      assert_match /chocolate or roast character/, @first_style.description
      assert_match /citrusy flavors/, @first_style.description
      assert_match /Rogue Red Ale/, @first_style.description
    end
  end

  def load_file
    filename = Rails.root.to_s + '/vendor/plugins/beer_xml/test/beer_styles.xml'
  end

end
