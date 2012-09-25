class Recipe < ActiveRecord::Base
    attr_accessible :beer_style, :mash_type, :name, :batch_size, :description,
      :original_gravity, :final_gravity, :bitterness, :color, :procedure,
      :hop_additions_attributes

    belongs_to :beer_style
    belongs_to :user
    has_many   :hop_additions
    has_many   :yeast_additions
    has_many   :fermentable_additions

    accepts_nested_attributes_for :hop_additions, :allow_destroy => :true,
      :reject_if => proc { |attrs| attrs['hop_id'].blank? }

    validates_presence_of :name, :batch_size, :description
    validates_inclusion_of :mash_type, :in => ['extract', 'grain', 'partial']
end
