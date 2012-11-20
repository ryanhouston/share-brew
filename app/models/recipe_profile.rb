class RecipeProfile
  def initialize( recipe )
    @recipe = recipe
  end

  def attenuation
    additions = @recipe.yeast_additions
    if additions.size > 0
      average_attenuation_for_additions additions
    else
      0
    end
  end

  def average_attenuation_for_additions( additions )
    additions.inject(0.0) do |total, addition|
      total + addition.yeast.attenuation
    end.to_f / additions.size
  end

  def calculated_starting_gravity
    @recipe.malt_bill.starting_gravity.round(3)
  end

  def calculated_final_gravity
    ((calculated_final_gravity_units / 1000) + 1).round(3)
  end

  def calculated_final_gravity_units
    @recipe.malt_bill.starting_gravity_units * (1 - (attenuation / 100))
  end

  def IBUs
    calculator = IBUCalculator.new

    @recipe.hop_additions.inject(0) do |ibu_sum, addition|
      ibu_sum + addition.IBUs
    end
  end

end

