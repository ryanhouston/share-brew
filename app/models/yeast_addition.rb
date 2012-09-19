class YeastAddition < ActiveRecord::Base
  belongs_to :yeast
  belongs_to :recipe
  attr_accessible :recipe_id, :yeast_id, :starter_size, :use_starter
end

