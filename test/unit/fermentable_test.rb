require 'test_helper'

class FermentableTest < ActiveSupport::TestCase

  context "The Fermentable class" do
    should "act as beer importer of fermentables" do
      assert_respond_to Fermentable, :acts_as_beer_importer_of
      assert_respond_to Fermentable, :import_beer_xml
    end

    should "be able to import a beer XML file of fermentables" do
      fermentables = Fermentable.import_beer_xml load_fermentables_xml
      assert_instance_of Array, fermentables
      malt = fermentables[1]
      assert_instance_of Fermentable, malt
      assert_equal 'Weyermann', malt.vendor
      assert_equal 'Acidulated (Weyermann)', malt.name
      assert_equal 'Germany', malt.origin
      assert_equal 65.2, malt.yield
      assert_equal "Used in Germany to lower PH levels without resorting to chemicals.  Lowers mash pH levels, lightens color, improves flavor stability.", malt.notes
      assert_equal 1.8, malt.color
      assert_equal 1.030, malt.potential
      assert_equal 10, malt.max_in_batch
      assert_equal Fermentable::GRAIN, malt.form
    end
  end

  def load_fermentables_xml
    filename = Rails.root + 'test/fixtures/grain.xml'
  end

end
