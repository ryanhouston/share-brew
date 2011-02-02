class BeerStyle < ActiveRecord::Base
    ALE = 0
    LAGER = 1

    validates_uniqueness_of :name, :case_sensitivity => false
    validates_presence_of :name, :description, :category
    validates_inclusion_of :min_orig_grav, :in => (0.0001..4.0001)
    validates_inclusion_of :max_orig_grav, :in => (0.0001..4.0001)
    validates_inclusion_of :min_final_grav, :in => (0.0001..4.0001)
    validates_inclusion_of :max_final_grav, :in => (0.0001..4.0001)

    has_many :recipes

    acts_as_beer_importer_of :styles

    attr_accessor :name, :description, :category
end
