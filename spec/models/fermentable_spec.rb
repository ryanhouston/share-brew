require 'spec_helper'

describe Fermentable do
  context "The Fermentable class" do
    it "acts as beer importer of fermentables" do
      Fermentable.should respond_to(:acts_as_beer_importer_of)
      Fermentable.should respond_to(:import_beer_xml)
    end

    it "can import a beer XML file of fermentables" do
      fermentables = Fermentable.import_beer_xml(load_fermentables_xml)
      fermentables.should be_kind_of(Array)

      malt = fermentables[1]
      malt.should be_kind_of(Fermentable)
      malt.vendor.should eq 'Weyermann'
      malt.name.should eq 'Acidulated (Weyermann)'
      malt.origin.should eq 'Germany'
      malt.yield.should eq 65.2
      malt.notes.should eq "Used in Germany to lower PH levels without resorting to chemicals.  Lowers mash pH levels, lightens color, improves flavor stability."
      malt.color.should eq 1.8
      malt.potential.should eq 1.030
      malt.max_in_batch.should eq 10
      malt.form.should eq Fermentable::GRAIN
    end

    def load_fermentables_xml
      filename = Rails.root + 'spec/fixtures/grain.xml'
    end
  end
end

