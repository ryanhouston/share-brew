class RecipeProfile
  def initialize( recipe )
    @recipe = recipe
  end

  def calculated_starting_gravity
    @recipe.malt_bill.starting_gravity.round(3)
  end

  def IBUs
    calculator = IBUCalculator.new

    @recipe.hop_additions.inject(0) do |ibu_sum, addition|
      ibu_sum + calculator.IBUs_for_addition(
        weight:       addition.weight,
        alpha_acid:   addition.alpha_acid,
        batch_size:   @recipe.batch_size,
        boil_time:    @recipe.boil_length,
        boil_gravity: calculated_starting_gravity
      )
    end
  end

end

