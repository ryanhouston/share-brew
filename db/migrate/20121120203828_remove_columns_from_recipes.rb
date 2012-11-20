class RemoveColumnsFromRecipes < ActiveRecord::Migration
  def change
    remove_columns(:recipes, :bitterness, :color)
  end
end
