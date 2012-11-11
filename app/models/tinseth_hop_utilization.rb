class TinsethHopUtilization
  def self.utilization( boil_gravity, boil_time )
    utilization_due_to_gravity(boil_gravity) * utilization_for_time(boil_time)
  end

  def self.utilization_due_to_gravity( boil_gravity )
    1.65 * 0.000125**(boil_gravity - 1)
  end

  def self.utilization_for_time( boil_time )
    (1 - Math.exp(-0.04 * boil_time)) / 4.15
  end
end

