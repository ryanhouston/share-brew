class Yeast < ActiveRecord::Base
  Forms = ['dry', 'liquid'] 

  validates_presence_of :strain, :catalog_id, :vendor, :form
  validates_uniqueness_of :catalog_id, :scope => :vendor, :case_sensitive => true,
	:message => "should be unique per vendor"
  validates_inclusion_of :form, :in => Forms,
	:message => "%{value} is not a valid form of yeast"

  acts_as_beer_importer_of(:yeasts).translated_as({
    :name   => :strain,
    :laboratory => :vendor,
    :product_id => :catalog_id,
    :notes => :description,
    :min_temperature => :min_temp,
    :max_temperature => :max_temp,
  })

end
