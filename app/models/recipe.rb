class Recipe < ActiveRecord::Base
    validates_presence_of :name, :batch_size, :description, :procedure
    validates_inclusion_of :mash_type, :in => ['extract', 'grain', 'partial']

    belongs_to :beer_style
end
