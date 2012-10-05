require 'factory_girl'

FactoryGirl.define do
  factory :beer_style do
    name 'Beer'
    description 'A generic beer for testing.'
    category 'American Ale'
    min_orig_grav '1.038'
    max_orig_grav '1.070'
    min_final_grav '1.002'
    max_final_grav '1.017'
  end

  factory :recipe do
    name 'Recipe'
    batch_size '1'
    description 'A generic recipe for testing.'
    procedure 'A generic procedure for testing.'
    mash_type 'partial'
  end

  factory :yeast do
    strain 'American Ale'
    catalog_id '1056'
    form 'liquid'
    vendor 'Wyeast'
  end

  factory :fermentable do
    name   'Pale Malt'
    origin 'US'
    vendor 'Rahr'
    form 'Grain'
    color '2'
    potential '1.058'
  end
end
