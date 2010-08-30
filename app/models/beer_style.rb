class BeerStyle < ActiveRecord::Base
    validates_presence_of :name, :description

    has_many :recipes
end
