class Hop < ActiveRecord::Base
  AROMA = 'Aroma';
  BITTERING = 'Bittering';
  PELLET = 'Pellet';
  PLUG = 'Plug';
  LEAF = 'Leaf';

  validates_presence_of :name
  validates_presence_of :alpha_acid
  validates_presence_of :form
  validates_presence_of :typical_use

end