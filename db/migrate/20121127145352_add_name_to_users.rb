class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, length: 255
  end
end
