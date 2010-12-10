require 'test_helper'

class YeastTest < ActiveSupport::TestCase
  context "a yeast strain" do

  	setup do
  	  @yeast = Factory(:yeast)
  	end 

	[:strain, :catalog_id, :vendor, :form].each do |value|
  	  should validate_presence_of value
    end
    ## SKIP - should work but shoulda is not filling other required fields
  	# should validate_uniqueness_of(:catalog_id).scoped_to(:vendor)
	%w(dry liquid).each do |value|
  		should allow_value(value).for(:form)
	end
	%w(slant 1).each do |value|
  		should_not allow_value(value).for(:form)
	end

  end

end
