class CreateBeerStyles < ActiveRecord::Migration
  def self.up
    create_table :beer_styles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :beer_styles
  end
end
