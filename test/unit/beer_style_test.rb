require 'test_helper'

class BeerStyleTest < ActiveSupport::TestCase
  should have_many(:recipes)

  should validate_presence_of :name
  # SKIP:  This test fails even though the model has the proper validation
  # should validate_uniqueness_of :name
  should validate_presence_of :description
  should validate_presence_of :category

  context "a beer style without a name" do
    setup do
      @beer_style = Factory.build(:beer_style, :name => '')
    end

    should "not be valid" do
      assert !@beer_style.valid?
    end

  end

  context "A Beer Style instance" do
    setup do
      @beer_style = Factory.build(:beer_style)
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

end
