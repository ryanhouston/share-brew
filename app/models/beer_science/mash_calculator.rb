class MashCalculator
  WATER_RETENTION_COEFFICIENT = 0.5

  attr_accessor :mash_ratio

  def initialize( total_grain_weight, batch_size )
    @total_grain_weight = total_grain_weight
    @batch_size = batch_size
  end

  def mash_ratio
    @mash_ratio ||= suggested_mash_ratio
  end

  # Provides a suggested mash ratio based on the total amount of grain and the
  # preboil volume of wort required to reach the desired finishing batch size
  def suggested_mash_ratio
    (preboil_volume + (preboil_volume*2 + 2*WATER_RETENTION_COEFFICIENT *
      preboil_volume * @total_grain_weight)**0.5) / @total_grain_weight
  end

  def required_mash_water_volume_in_quarts
    suggested_mash_ratio * @total_grain_weight
  end

  def required_mash_water_volume_in_gallons
    required_mash_water_volume_in_quarts / 4
  end

  # TODO should really be an equation based off the desired ending batch
  # volume taking into account: amount of wort boiled off, loss to cooling
  # (with regard to water expansion due to temperature), loss to cooling
  # equipment (a counterflow chiller might trap some wort), and loss to trub.
  def preboil_volume
    7.5
  end

end

