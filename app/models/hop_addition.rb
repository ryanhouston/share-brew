class HopAddition < ActiveRecord::Base
  attr_accessible :hop_id, :recipe_id, :alpha_acid, :beta_acid, :form, :duration, :weight, :use
  belongs_to :recipe
  belongs_to :hop

  validates :recipe_id, :presence => true
  validates :hop_id, :presence => true
end
