class ModifyYeasts < ActiveRecord::Migration
  def self.up
    change_table :yeasts do |y|
      y.remove :use_starter, :min_temp, :max_temp
      y.string :flocculation 
      y.string :strain_type
      y.float :min_temp
      y.float :max_temp
    end
  end

  def self.down
    change_table :yeasts do |y|
      y.boolean :use_starter
      y.remove :flocculation
      y.remove :strain_type
    end
  end
end
