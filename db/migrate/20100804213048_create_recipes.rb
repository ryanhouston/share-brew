class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.string :name, :null => false
      t.string :mash_type, :null => false
      t.text :description
      t.string :batch_size
      t.string :original_gravity
      t.string :final_gravity
      t.string :bitterness
      t.string :color
      t.text :procedure
      t.references :beer_style

      t.timestamps
    end
  end

  def self.down
    drop_table :recipes
  end
end
