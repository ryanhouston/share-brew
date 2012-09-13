class DropTableIngredients < ActiveRecord::Migration
  def up
    drop_table :ingredients
    drop_table :recipe_ingredients
  end

  def down
    create_table "ingredients", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.string   "ingredient_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "recipe_ingredients", :force => true do |t|
      t.integer  "recipe_id"
      t.integer  "ingredient_id"
      t.string   "quantity"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
