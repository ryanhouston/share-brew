class YeastAddition < ActiveRecord::Base
  belongs_to :yeast
  belongs_to :recipe

  def update_with_callbacks( params, callbacks = {} )
    if update_attributes(params)
      callbacks[:success].try(:call, self)
    else
      callbacks[:failure].try(:call, self)
    end
  end
end

