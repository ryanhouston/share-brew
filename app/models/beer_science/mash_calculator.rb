module BeerScience
  class MashCalculator
    WATER_RETENTION_COEFFICIENT = 0.5

    attr_accessor :mash_ratio

    def initialize( total_grain_weight_lbs, batch_size_gallons, boil_minutes)
      @total_grain_weight_lbs = total_grain_weight_lbs.to_f
      @batch_size_gallons     = batch_size_gallons.to_f
      @boil_minutes           = boil_minutes.to_f
    end

    def mash_ratio
      @mash_ratio ||= suggested_mash_ratio
    end

    # Provides a suggested mash ratio based on the total amount of grain and the
    # preboil volume of wort required to reach the desired finishing batch size
    #
    # Formula lifted from John Palmer's "How to Brew"
    def suggested_mash_ratio
      (preboil_volume_gallons + (preboil_volume_gallons*2 + 2*WATER_RETENTION_COEFFICIENT *
        preboil_volume_gallons * @total_grain_weight_lbs)**0.5) / @total_grain_weight_lbs
    end

    def required_mash_water_volume_in_quarts
      mash_ratio * @total_grain_weight_lbs
    end

    def required_mash_water_volume_in_gallons
      required_mash_water_volume_in_quarts / 4
    end

    # TODO should really be an equation based off the desired ending batch
    # volume taking into account: amount of wort boiled off, loss to cooling
    # (with regard to water expansion due to temperature), loss to cooling
    # equipment (a counterflow chiller might trap some wort), and loss to trub.
    def preboil_volume_gallons
      boil_off_gallons + @batch_size_gallons
    end

    # Boil off rate is relatively constant based on the diameter of the boil
    # kettle. Environmental factors and boil vigor can contribute as well.
    def boil_off_gallons
      (@boil_minutes.to_f / 60.to_f) * boil_off_gallons_per_hour.to_f
    end

    # TODO this should be specified by brewer inputs specific to their brew rig.
    #   Currently this is hard-coded to a rate of 1 gallon per hour
    def boil_off_gallons_per_hour
      1.0
    end

    def sparge_water_volume_gallons
      preboil_volume_gallons - required_mash_water_volume_in_gallons
    end
  end
end

