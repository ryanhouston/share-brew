require 'spec_helper'

describe Yeast do
  it { should validate_presence_of( :strain ) }
  it { should validate_presence_of( :catalog_id ) }
  it { should validate_presence_of( :vendor ) }
  it { should validate_presence_of( :form ) }

  it { should ensure_inclusion_of( :form ).in_array( Yeast::FORMS ) }
  it { should ensure_inclusion_of(:strain_type).in_array( Yeast::STRAIN_TYPES ) }

  it "acts as a beer xml importer" do
    Yeast.should respond_to(:acts_as_beer_importer_of)
    Yeast.should respond_to(:import_beer_xml)
  end

  context "A collection of Yeasts imported from beer xml" do
    subject do
      yeasts = Yeast.import_beer_xml(load_file)
      @yeast = yeasts.first
    end

    it { should be_kind_of(Yeast) }
    its( :strain ) { should eq "American Megabrewery" }
    its( :vendor ) { should eq "Brewtek" }
    its( :catalog_id ) { should eq "CL-0620" }
    its( :min_temp ) { should eq 8.8889 }
    its( :max_temp ) { should eq 14.4444 }
    its( :attenuation ) { should eq 73.00 }
    its( :flocculation ) { should eq 'Medium' }
    its( :form ) { should eq 'liquid' }
    its( :strain_type ) { should eq 'lager' }

    def load_file
      file = Rails.root + 'test/fixtures/yeast.xml'
    end
  end
end

