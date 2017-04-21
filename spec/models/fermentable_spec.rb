require 'rails_helper'

describe Fermentable do
  context "The Fermentable class" do
    it "acts as beer importer of fermentables" do
      expect(Fermentable).to respond_to(:acts_as_beer_importer_of)
      expect(Fermentable).to respond_to(:import_beer_xml)
    end

    it "can import a beer XML file of fermentables" do
      fermentables = Fermentable.import_beer_xml(load_fermentables_xml)
      expect(fermentables).to be_kind_of(Array)

      malt = fermentables[1]
      expect(malt).to be_kind_of(Fermentable)
      expect(malt.vendor).to eq 'Weyermann'
      expect(malt.name).to eq 'Acidulated (Weyermann)'
      expect(malt.origin).to eq 'Germany'
      expect(malt.yield).to eq 65.2
      expect(malt.notes).to eq "Used in Germany to lower PH levels without resorting to chemicals.  Lowers mash pH levels, lightens color, improves flavor stability."
      expect(malt.color).to eq 1.8
      expect(malt.potential).to eq 1.030
      expect(malt.max_in_batch).to eq 10
      expect(malt.form).to eq Fermentable::GRAIN
    end

    def load_fermentables_xml
      filename = Rails.root + 'spec/fixtures/grain.xml'
    end

    context "#potential_in_GUs" do
      subject { FactoryGirl.build :fermentable, potential: 1.038 }
      its (:potential_in_GUs) { should == 38 }
    end
  end
end

