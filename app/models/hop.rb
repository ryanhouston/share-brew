class Hop < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :alpha_acid
  validates_presence_of :form
  validates_presence_of :typical_use

end
