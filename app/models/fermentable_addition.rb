class FermentableAddition < ActiveRecord::Base
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

  def percentage_of_malt_bill
    weight / recipe.malt_bill.total_weight * 100
  end

  # Also referred to as MCUs. This is the amount of color this particular
  # malt addition adds to the recipe
  def malt_color_units
    weight * fermentable.color
  end
  alias :MCUs :malt_color_units

end

