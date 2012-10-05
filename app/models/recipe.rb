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
    add_ingredient :fermentable, params, callbacks
  end

  def add_hop( params, callbacks )
    add_ingredient(:hop, params, callbacks)
  end

  private
  def add_ingredient( type, params, callbacks )
    type_additions = send (type.to_s + '_additions').to_sym
    ingredient_addition = type_additions.build params

    if ingredient_addition.save
      callbacks[:success].try(:call, ingredient_addition)
    else
      callbacks[:failure].try(:call, ingredient_addition)
    end
  end
end
