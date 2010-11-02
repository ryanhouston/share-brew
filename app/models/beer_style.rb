class BeerStyle < ActiveRecord::Base
    validates_uniqueness_of :name
    validates_presence_of :name, :description, :category

    has_many :recipes
end
