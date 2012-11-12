class IBUCalculator
  def AAUs_for_addition(weight, alpha_acid)
    weight * alpha_acid
  end

  def hop_utilization( boil_gravity, boil_time )
    TinsethHopUtilization.utilization(boil_gravity, boil_time)
  end

  def IBUs_for_addition( attrs = {} )
    AAUs_for_addition(attrs[:weight], attrs[:alpha_acid]) *
      hop_utilization(attrs[:boil_gravity], attrs[:boil_time]) *
      75 / attrs[:batch_size]
  end
end

