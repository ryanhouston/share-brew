class FermentableAddition < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :fermentable

  validates :recipe_id, :presence => true
  validates :fermentable_id, :presence => true
end
