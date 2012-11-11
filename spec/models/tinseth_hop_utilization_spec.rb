require 'spec_helper'
require 'tinseth_hop_utilization'

describe TinsethHopUtilization do
  it "provides the hop utilization measurement for the boil" do
    # See Table 7 provided at http://www.howtobrew.com/section1/chapter5-5.html
    TinsethHopUtilization.utilization(1.060, 60).round(3).should == 0.211
  end
end

