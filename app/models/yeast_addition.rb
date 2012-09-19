class YeastAddition < ActiveRecord::Base
  belongs_to :yeast
  belongs_to :recipe
  attr_accessible :starter_size, :use_starter?
end

