class Yeast < ActiveRecord::Base
  Forms = ['dry', 'liquid']
  StrainTypes = ['ale', 'lager', 'champagne', 'wine', 'cider']

  attr_accessible :strain, :vendor, :form, :description, :min_temp, :max_temp, :catalog_id, :attenuation

  validates_presence_of :strain, :catalog_id, :vendor, :form
  validates_inclusion_of :form, :in => Forms,
    :message => "%{value} is not a valid form of yeast"

  # Apparently not all vendors use proper product IDs. Brewtek had dupes
  # while Danstar provides none in the beersmith 1.0 export.
  #validates_uniqueness_of :catalog_id, :scope => :vendor, :case_sensitive => true,
  #  :message => "should be unique per vendor"
  #validates_inclusion_of :strain_type, :in => StrainTypes,
  #:message => "%{value} is not a valid type of yeast"

  acts_as_beer_importer_of(:yeasts).translated_as({
    :name   => :strain,
    :laboratory => :vendor,
    :product_id => :catalog_id,
    :notes => :description,
    :min_temperature => :min_temp,
    :max_temperature => :max_temp,
  }).using({
    :form => :translate_form,
    :strain_type => :translate_strain_type,
  })

  def translate_form yeast_attrs
    write_attribute :form, yeast_attrs['FORM'].downcase
  end

  def translate_strain_type yeast_attrs
    write_attribute :strain_type, yeast_attrs['TYPE'].downcase
  end

  def name
    strain
  end
end
