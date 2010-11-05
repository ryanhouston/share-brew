require 'test_helper'

class HopTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should validate_presence_of :alpha_acid
  should validate_presence_of :form
  should validate_presence_of :typical_use

end
