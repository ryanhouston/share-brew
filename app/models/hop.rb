require 'beer_xml'

class Hop < ActiveRecord::Base
  include BeerXml

  AROMA = 'Aroma'
  BITTERING = 'Bittering'
  PELLET = 'Pellet'
  PLUG = 'Plug'
  LEAF = 'Leaf'

  attr_accessible :name, :alpha_acid, :beta_acid, :form, :typical_use, :notes, :origin

  validates_presence_of :name
  validates_presence_of :alpha_acid
  validates_presence_of :form
  validates_presence_of :typical_use

  acts_as_beer_importer_of(:hops).translated_as({
    :alpha => :alpha_acid,
    :beta => :beta_acid,
    :use => :typical_use,
  })

end
