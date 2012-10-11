class YeastAddition < ActiveRecord::Base
  belongs_to :yeast
  belongs_to :recipe
  attr_accessible :recipe_id, :yeast_id, :starter_size, :use_starter

  def update_with_callbacks( params, callbacks = {} )
    if update_attributes(params)
      callbacks[:success].try(:call, self)
    else
      callbacks[:failure].try(:call, self)
    end
  end
end

