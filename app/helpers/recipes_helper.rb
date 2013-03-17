module RecipesHelper
  def format_gravity( gravity_value )
    if gravity_value.to_s.empty?
      'N/A'
    else
      format('%1.3f', gravity_value.to_f.round(3))
    end
  end

  def recipe_builder_active_tab_name
    @tab_active ||= :overview
  end

  def recipe_builder_active_tab_index
    case recipe_builder_active_tab_name
    when :overview    then 0
    when :ingredients then 1
    when :mash        then 2
    else :overview
    end
  end
end

