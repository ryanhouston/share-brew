class FermentableAddition < ActiveRecord::Base
  attr_accessible :fermentable_id, :recipe_id, :weight
  belongs_to :recipe
  belongs_to :fermentable

  validates :recipe_id, :presence => true
  validates :fermentable_id, :presence => true
  validates :weight, :presence => true, :numericality => true

  def update_with_callbacks( params, callbacks = {} )
    if update_attributes(params)
      callbacks[:success].try(:call, self)
    else
      callbacks[:failure].try(:call, self)
    end
  end
end
