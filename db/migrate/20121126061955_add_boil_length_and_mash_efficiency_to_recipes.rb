class AddBoilLengthAndMashEfficiencyToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :boil_length, :integer
    add_column :recipes, :mash_efficiency, :decimal
  end
end
