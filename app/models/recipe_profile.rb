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
      ibu_sum + addition.IBUs
    end
  end

end

