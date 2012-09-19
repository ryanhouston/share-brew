class CreateYeastAdditions < ActiveRecord::Migration
  def change
    create_table :yeast_additions do |t|
      t.boolean :use_starter
      t.integer :starter_size
      t.references :yeast
      t.references :recipe

      t.timestamps
    end
    add_index :yeast_additions, :yeast_id
    add_index :yeast_additions, :recipe_id
  end
end

