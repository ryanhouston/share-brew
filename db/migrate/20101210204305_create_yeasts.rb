class CreateYeasts < ActiveRecord::Migration
  def self.up
    create_table :yeasts do |t|
      t.string :vendor
      t.string :strain
      t.string :catalog_id
      t.string :form
      t.text :description
      t.boolean :use_starter
      t.integer :min_temp
      t.integer :max_temp
      t.float :attentuation

      t.timestamps
    end
  end

  def self.down
    drop_table :yeasts
  end
end
