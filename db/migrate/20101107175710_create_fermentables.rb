class CreateFermentables < ActiveRecord::Migration
  def self.up
    create_table :fermentables do |t|
      t.string :name
      t.string :origin
      t.string :vendor
      t.string :form
      t.float :color
      t.decimal :potential, :precision => 5, :scale => 4
      t.float :yield
      t.float :max_in_batch
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :fermentables
  end
end
