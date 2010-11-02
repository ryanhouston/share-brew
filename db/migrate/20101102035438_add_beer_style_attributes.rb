class AddBeerStyleAttributes < ActiveRecord::Migration
  def self.up
    change_table :beer_styles do |t|
      t.string :category
      t.boolean :lager, :default => false
      t.decimal :min_orig_grav, :precision => 5, :scale => 4
      t.decimal :max_orig_grav, :precision => 5, :scale => 4
      t.decimal :min_final_grav, :precision => 5, :scale => 4
      t.decimal :max_final_grav, :precision => 5, :scale => 4
      t.decimal :min_IBUs, :precision => 4, :scale => 2
      t.decimal :max_IBUs, :precision => 4, :scale => 2
      t.float :min_color
      t.float :max_color
      t.float :min_carbonation
      t.float :max_carbonation
      t.float :min_abv
      t.float :max_abv
    end
  end

  def self.down
    change_table :beer_styles do |t|
      t.remove :category, :lager, :min_orig_grav, :max_orig_grav, :min_final_grav,
       :max_final_grav, :min_IBUs, :max_IBUs, :min_color, :max_color,
       :min_carbonation, :max_carbonation, :min_abv, :max_abv
    end
  end
end
