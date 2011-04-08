require 'test_helper'

class HopTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should validate_presence_of :alpha_acid
  should validate_presence_of :form
  should validate_presence_of :typical_use

  context "The Hop class" do
    should "act as an importer of hops" do
      assert_respond_to Hop, :acts_as_beer_importer_of
      assert_respond_to Hop, :import_beer_xml
    end
  end
end
