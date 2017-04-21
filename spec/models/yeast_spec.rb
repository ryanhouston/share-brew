require 'rails_helper'

describe Yeast do
  it { is_expected.to validate_presence_of( :strain ) }
  it { is_expected.to validate_presence_of( :catalog_id ) }
  it { is_expected.to validate_presence_of( :vendor ) }
  it { is_expected.to validate_presence_of( :form ) }

  it { is_expected.to validate_inclusion_of( :form ).in_array( Yeast::FORMS ) }
  it { is_expected.to validate_inclusion_of(:strain_type).in_array( Yeast::STRAIN_TYPES ) }

  it "acts as a beer xml importer" do
    expect(Yeast).to respond_to(:acts_as_beer_importer_of)
    expect(Yeast).to respond_to(:import_beer_xml)
  end

  context "A collection of Yeasts imported from beer xml" do
    subject do
      yeasts = Yeast.import_beer_xml(load_file)
      @yeast = yeasts.first
    end

    it { is_expected.to be_kind_of(Yeast) }
    its( :strain ) { should eq "Cooper Ale" }
    its( :vendor ) { should eq "Coopers" }
    its( :catalog_id ) { should eq "-" }
    its( :min_temp ) { should eq 16.6667 }
    its( :max_temp ) { should eq 22.2222 }
    its( :attenuation ) { should eq 75.00 }
    its( :flocculation ) { should eq 'Medium' }
    its( :form ) { should eq 'dry' }
    its( :strain_type ) { should eq 'ale' }

    def load_file
      file = Rails.root + 'spec/fixtures/yeast.xml'
    end
  end
end

