require 'rails_helper'

describe Hop do
  it { should validate_presence_of :name }
  it { should validate_presence_of :alpha_acid }
  it { should validate_presence_of :form }
  it { should validate_presence_of :typical_use }

  context "The Hop class" do
    it "acts as an importer of hops" do
      Hop.should respond_to(:acts_as_beer_importer_of)
      Hop.should respond_to(:import_beer_xml)
    end
  end
end

