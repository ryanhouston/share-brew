ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'factory_girl'
require 'redgreen'

require File.dirname(__FILE__) + "/../spec/factories"

