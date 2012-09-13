class CreateHopAdditions < ActiveRecord::Migration
  def change
    create_table :hop_additions do |t|
      t.references :hop
      t.references :recipe
      t.decimal :alpha_acid, :precision => 4, :scale => 2, :null => false
      t.decimal :beta_acid,  :precision => 4, :scale => 2
      t.decimal :weight, :null => false
      t.string  :form, :null => false
      t.integer :duration, :null => false
      t.string  :use, :null => false

      t.timestamps
    end
    add_index :hop_additions, :hop_id
  end
end
