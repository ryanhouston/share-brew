class Yeast < ActiveRecord::Base
  Forms = ['dry', 'liquid'] 

  validates_presence_of :strain, :catalog_id, :vendor, :form
  validates_uniqueness_of :catalog_id, :scope => :vendor, :case_sensitive => true,
	:message => "should be unique per vendor"
  validates_inclusion_of :form, :in => Forms,
	:message => "%{value} is not a valid form of yeast"

end
