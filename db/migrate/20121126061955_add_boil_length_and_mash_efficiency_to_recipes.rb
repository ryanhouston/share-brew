class AddBoilLengthAndMashEfficiencyToRecipes < ActiveRecord::Migration
  class Recipe < ActiveRecord::Base; end

  def change
    add_column :recipes, :boil_length, :integer, null: false, default: 60
    add_column :recipes, :mash_efficiency, :decimal

    Recipe.reset_column_information
    Recipe.all.each do |recipe|
      recipe.mash_efficiency = 0.68
      recipe.save!
    end
  end
end
