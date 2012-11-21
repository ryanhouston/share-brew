module BeerScience
  class ColorCalculator
    def initialize( malt_bill )
      @malt_bill = malt_bill
    end

    def total_MCUs
      @malt_bill.fermentables.inject(0.0) do |total, addition|
        total + addition.malt_color_units
      end
    end

    def MCUs_per_gallon
      (total_MCUs / @malt_bill.batch_size.to_f).round(1)
    end

    def SRM
      # Return SRM of beer using Morey's formula
      morey_SRM.round(1)
    end

    def morey_SRM
      1.49 * self.MCUs_per_gallon**0.69
    end
  end
end

