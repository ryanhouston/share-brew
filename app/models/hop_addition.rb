class HopAddition < ActiveRecord::Base
  belongs_to :hop
  belongs_to :recipe
  attr_accessible :hop_id, :alpha_acid, :beta_acid, :form, :duration, :weight, :use
end
