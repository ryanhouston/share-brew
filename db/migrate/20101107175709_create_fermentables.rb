class CreateFermentables < ActiveRecord::Migration
  def self.up
    create_table :fermentables do |t|
      t.string :name
      t.string :origin
      t.string :vendor
      t.string :form
      t.decimal :color
      t.decimal :potential
      t.decimal :yield
      t.decimal :max_in_batch
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :fermentables
  end
end
