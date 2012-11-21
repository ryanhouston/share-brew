class HopAddition < ActiveRecord::Base
  attr_accessible :hop_id, :recipe_id, :alpha_acid, :beta_acid, :form, :duration, :weight, :use
  belongs_to :recipe
  belongs_to :hop

  validates :recipe_id,   presence: true
  validates :hop_id,      presence: true
  validates :alpha_acid,  presence: true, numericality: true
  validates :beta_acid,   numericality:   { allow_blank: true }
  validates :form,        presence: true
  validates :duration,    presence: true, numericality: true
  validates :weight,      presence: true, numericality: true
  validates :use,         presence: true

  def update_with_callbacks( params, callbacks = {} )
    if update_attributes(params)
      callbacks[:success].try(:call, self)
    else
      callbacks[:failure].try(:call, self)
    end
  end

  def IBUs
    calculator = BeerScience::IBUCalculator.new
    calculator.IBUs_for_addition(
      weight:       weight,
      alpha_acid:   alpha_acid,
      boil_time:    duration,
      batch_size:   recipe.batch_size,
      boil_gravity: recipe.profile.calculated_starting_gravity
    )
  end
end

