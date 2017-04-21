require 'rails_helper'

describe Hop do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :alpha_acid }
  it { is_expected.to validate_presence_of :form }
  it { is_expected.to validate_presence_of :typical_use }

  context "The Hop class" do
    it "acts as an importer of hops" do
      expect(Hop).to respond_to(:acts_as_beer_importer_of)
      expect(Hop).to respond_to(:import_beer_xml)
    end
  end
end

