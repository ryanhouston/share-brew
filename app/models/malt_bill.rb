class MaltBill
  attr_accessor :fermentables, :batch_size, :mash_efficiency

  def initialize(attributes = {})
    @fermentables = attributes[:fermentables]
    @batch_size   = attributes[:batch_size]
    @mash_efficiency = attributes[:mash_efficiency]
  end

  def starting_gravity
    (total_gravity_units / batch_size / 1000) + 1
  end

  def total_gravity_units
    fermentables.inject(0.0) do |total, fermentable_addition|
      total + fermentable_gravity_units(fermentable_addition)
    end
  end

  def fermentable_gravity_units(fermentable_addition)
    (fermentable_addition.weight * fermentable_addition.fermentable.potential_in_GUs * mash_efficiency)
  end
end

