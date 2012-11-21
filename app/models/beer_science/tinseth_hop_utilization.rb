module BeerScience
  class TinsethHopUtilization
    attr_reader :boil_gravity, :boil_time

    def initialize( boil_gravity, boil_time )
      @boil_gravity = boil_gravity
      @boil_time = boil_time
    end

    def self.utilization( boil_gravity, boil_time )
      tinseth = self.new(boil_gravity, boil_time).utilization
    end

    def utilization
      utilization_due_to_gravity * utilization_for_time
    end

    def utilization_due_to_gravity
      1.65 * 0.000125**(boil_gravity - 1)
    end

    def utilization_for_time
      (1 - Math.exp(-0.04 * boil_time)) / 4.15
    end
  end
end

