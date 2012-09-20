class FermentableAddition < ActiveRecord::Base
  attr_accessible :fermentable_id, :recipe_id, :weight
  belongs_to :recipe
  belongs_to :fermentable

  validates :recipe_id, :presence => true
  validates :fermentable_id, :presence => true
end
