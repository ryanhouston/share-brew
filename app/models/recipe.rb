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

  def add_fermentable( params, callbacks={} )
    add_ingredient :fermentable, params, callbacks
  end

  def add_hop( params, callbacks={} )
    add_ingredient(:hop, params, callbacks)
  end

  def add_yeast( params, callbacks={} )
    add_ingredient(:yeast, params, callbacks)
  end

  def self.find_with_ingredients( id )
    Recipe.includes(
      hop_additions: :hop,
      fermentable_additions: :fermentable,
      yeast_additions: :yeast
    ).find( id )
  end

  def mash_efficiency
    # @todo set this from user input
    0.68
  end

  def boil_length
    # @todo set this from user input
    60
  end

  def malt_bill
    MaltBill.new(
      fermentables:     fermentable_additions,
      batch_size:       batch_size,
      mash_efficiency:  mash_efficiency
    )
  end

  def calculated_starting_gravity
    malt_bill.starting_gravity.round(3)
  end

  def IBUs
    calculator = IBUCalculator.new

    hop_additions.inject(0) do |ibu_sum, addition|
      ibu_sum + calculator.IBUs_for_addition(
        weight:       addition.weight,
        alpha_acid:   addition.alpha_acid,
        batch_size:   batch_size,
        boil_time:    boil_length,
        boil_gravity: calculated_starting_gravity
      )
    end
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

    ingredient_addition
  end
end
