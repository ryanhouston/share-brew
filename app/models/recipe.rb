class Recipe < ActiveRecord::Base
    belongs_to :beer_style
    belongs_to :user

    validates_presence_of :name, :batch_size, :description, :procedure
    validates_inclusion_of :mash_type, :in => ['extract', 'grain', 'partial']
end
