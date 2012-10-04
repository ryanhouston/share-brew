class Recipe < ActiveRecord::Base
  attr_accessible :beer_style, :mash_type, :name, :batch_size, :description,
    :original_gravity, :final_gravity, :bitterness, :color, :procedure

  belongs_to :beer_style
  belongs_to :user
  has_many   :hop_additions
  has_many   :yeast_additions
  has_many   :fermentable_additions

  validates_presence_of :name, :batch_size, :description
  validates_inclusion_of :mash_type, :in => ['extract', 'grain', 'partial']

  def add_fermentable( params, callbacks )
    @fermentable_addition = fermentable_additions.build(params)

    if @fermentable_addition.save
      callbacks[:success].call if callbacks[:success]
    else
      callbacks[:failure].call if callbacks[:failure]
    end
  end
end
