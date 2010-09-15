require 'test_helper'

class BeerStyleTest < ActiveSupport::TestCase
  should have_many(:recipes)

  should validate_presence_of :name
  should validate_presence_of :description

  context "a beer style without a name" do
    setup do
      @beer_style = Factory.build(:beer_style, :name => '')
    end

    should "not be valid" do
      assert !@beer_style.valid?
    end

  end
end
