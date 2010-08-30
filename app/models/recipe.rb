class Recipe < ActiveRecord::Base
    belongs_to :beer_style
    has_many :ingredients, :through => :recipe_ingredients

    validates_presence_of :name, :batch_size, :description, :procedure
    validates_inclusion_of :mash_type, :in => ['extract', 'grain', 'partial']

    accepts_nested_attributes_for :recipe_ingredients, :allow_destroy => true
end
