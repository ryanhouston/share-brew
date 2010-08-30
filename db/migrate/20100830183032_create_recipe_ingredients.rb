class CreateRecipeIngredients < ActiveRecord::Migration
  def self.up
    create_table :recipe_ingredients do |t|
      t.references :recipe
      t.references :ingredient
      t.string :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :recipe_ingredients
  end
end
