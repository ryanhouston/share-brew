module RecipesHelper
  def format_gravity( gravity_value )
    if gravity_value.to_s.empty?
      'N/A'
    else
      format('%1.3f', gravity_value.to_f.round(3))
    end
  end
end
