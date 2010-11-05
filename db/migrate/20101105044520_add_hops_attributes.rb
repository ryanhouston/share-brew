class AddHopsAttributes < ActiveRecord::Migration
  def self.up
    create_table :hops do |hops|
      hops.string :name
      hops.string :typical_use
      hops.decimal :alpha_acid, :precision => 4, :scale => 2
      hops.decimal :beta_acid, :precision => 4, :scale => 2
      hops.string :origin
      hops.string :form
      hops.text :notes

      hops.timestamps
    end
  end

  def self.down
    drop_table :hops
  end
end
