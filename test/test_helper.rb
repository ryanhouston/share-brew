ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'factory_girl'

Factory.define :beer_style do |b|
  b.name 'Beer'
  b.description 'A generic beer for testing.'
end

Factory.define :recipe do |r|
  r.name 'Recipe'
  r.batch_size '1'
  r.description 'A generic recipe for testing.'
  r.procedure 'A generic procedure for testing.'
  r.mash_type 'partial'
end

Factory.define :ingredient do |i|
  i.name 'Ingredient'
  i.description 'A generic ingredient for testing.'
  i.ingredient_type 'malt'
  i.association :recipe
end
