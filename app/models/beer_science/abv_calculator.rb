module BeerScience
  class ABVCalculator
    def self.calculate( original_gravity, final_gravity )
      original_gravity = original_gravity.to_f
      final_gravity = final_gravity.to_f

      (76.08 *(original_gravity - final_gravity) /
        (1.775 - original_gravity)) * (final_gravity / 0.794)
    end
  end
end

