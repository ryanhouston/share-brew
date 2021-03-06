class Recipe < ActiveRecord::Base
  belongs_to :beer_style
  belongs_to :user
  has_many   :hop_additions
  has_many   :yeast_additions
  has_many   :fermentable_additions

  validates_presence_of :name, :batch_size, :boil_length, :beer_style
  validates_associated :beer_style
  validates_inclusion_of :mash_type, :in => ['extract', 'grain', 'partial']
  validates_inclusion_of :boil_length, :in => 1..300
  validates :mash_efficiency,
    presence:     { if: :all_grain? },
    numericality: { greater_than: 0.0, less_than_or_equal_to: 100.0, allow_nil: true }

  def all_grain?
    mash_type == 'grain'
  end

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

  def malt_bill
    MaltBill.new(
      fermentables:     fermentable_additions,
      batch_size:       batch_size,
      mash_efficiency:  mash_efficiency
    )
  end

  def mash_efficiency
    all_grain? ? super : 100
  end

  def mash_calculator
    BeerScience::MashCalculator.new malt_bill.total_weight, batch_size, boil_length
  end

  def profile
    @profile ||= RecipeProfile.new(self)
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
