class Fermentable < ActiveRecord::Base
  GRAIN = 'Grain'
  DME = 'Dry Malt Extract'
  LME = 'Liquid Malt Extract'
  SUGAR = 'Sugar'
  ADJUNCT = 'Adjunct'

  attr_accessible :name, :origin, :vendor, :form, :color, :potential, :yield, :max_in_batch, :notes

  acts_as_beer_importer_of(:fermentables).translated_as({
   :supplier => :vendor,
  }).using({
    :form => :translate_form
  })

  def translate_form beer_attrs
    case beer_attrs['TYPE']
    when 'Grain'
      fermentable_form = GRAIN
    when 'Extract'
      fermentable_form = LME
    when 'Dry Extract'
      fermentable_form = DME
    when 'Sugar'
      fermentable_form = SUGAR
    when 'Adjunct'
      fermentable_form = ADJUNCT
    else
      fermentable_form = nil
    end
    write_attribute :form, fermentable_form
  end

end
