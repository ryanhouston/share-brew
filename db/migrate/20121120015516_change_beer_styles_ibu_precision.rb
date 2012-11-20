class ChangeBeerStylesIbuPrecision < ActiveRecord::Migration
  def change
    change_column(:beer_styles, :min_IBUs, :decimal, precision: 5, scale: 2)
    change_column(:beer_styles, :max_IBUs, :decimal, precision: 5, scale: 2)
  end
end
