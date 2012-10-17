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
    strain_type 'ale'
  end

  factory :fermentable do
    name   'Pale Malt'
    origin 'US'
    vendor 'Rahr'
    form 'Grain'
    color '2'
    potential '1.058'
  end

  factory :hop do
    name 'Cascade'
    typical_use 'Both'
    alpha_acid '4.5'
    beta_acid '3.2'
    origin 'US'
    form 'pellet'
    notes 'One of the "C" hops. Citrusy'
  end

  factory :user do
    email 'first@user.com'
    password 'password'
    password_confirmation 'password'
  end
end
