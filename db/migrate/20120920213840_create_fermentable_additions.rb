class CreateFermentableAdditions < ActiveRecord::Migration
  def change
    create_table :fermentable_additions do |t|
      t.references :recipe
      t.references :fermentable
      t.decimal :weight

      t.timestamps
    end
    add_index :fermentable_additions, :recipe_id
    add_index :fermentable_additions, :fermentable_id
  end
end
