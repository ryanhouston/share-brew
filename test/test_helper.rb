ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'factory_girl'
require 'redgreen'

Factory.define :beer_style do |b|
  b.name 'Beer'
  b.description 'A generic beer for testing.'
  b.category 'American Ale'
  b.min_orig_grav '1.038'
  b.max_orig_grav '1.070'
  b.min_final_grav '1.002'
  b.max_final_grav '1.017'
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

Factory.define :yeast do |y|
  y.strain 'American Ale'
  y.catalog_id '1056'
  y.form 'liquid'
  y.vendor 'Wyeast'
end
