require 'test_helper'

class YeastTest < ActiveSupport::TestCase
  context "a yeast strain" do

    setup do
      @yeast = FactoryGirl.build(:yeast)
    end

    [:strain, :catalog_id, :vendor, :form].each do |value|
      should validate_presence_of value
    end

    %w(dry liquid).each do |value|
      should allow_value(value).for(:form)
    end

    %w(slant 1).each do |value|
      should_not allow_value(value).for(:form)
    end

    Yeast::STRAIN_TYPES.each do |value|
      should allow_value(value).for(:strain_type)
    end
  end

  context "The Yeast class" do
    setup do
      @yeasts = Yeast.import_beer_xml load_file
    end

    should "act as a beer importer" do
      assert_respond_to Yeast, :acts_as_beer_importer_of
      assert_respond_to Yeast, :import_beer_xml
    end

    should "be import valid yeasts" do
      assert @yeasts.first.valid?
    end

    should "be able to import a beer xml file of yeasts" do
      yeast = @yeasts.first
      assert_instance_of Yeast, yeast
      assert_equal "American Megabrewery", yeast.strain
      assert_equal "Brewtek", yeast.vendor
      assert_equal "CL-0620", yeast.catalog_id
      assert_equal 8.8889, yeast.min_temp
      assert_equal 14.4444 , yeast.max_temp
      assert_equal 73.00, yeast.attenuation
      assert_equal 'Medium', yeast.flocculation
      assert_equal 'liquid', yeast.form
      assert_equal 'lager', yeast.strain_type
    end
  end

  def load_file
    file = Rails.root + 'test/fixtures/yeast.xml'
  end

end
