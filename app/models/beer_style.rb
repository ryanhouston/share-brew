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

    acts_as_beer_importer_of(:styles).translated_as({
      :abv_max => :max_abv, :abv_min => :min_abv,
      :og_min => :min_orig_grav, :og_max => :max_orig_grav,
      :fg_min => :min_final_grav, :fg_max => :max_final_grav,
      :ibu_min => :min_IBUs, :ibu_max => :max_IBUs,
      :color_min => :min_color, :color_max => :max_color,
      :carb_min => :min_carbonation, :carb_max => :max_carbonation,
      :abv_min => :min_abv, :abv_max => :max_abv,
    }).using({
      :description => :compose_description,
      :category => :combine_category_parts
    })


  private
    def compose_description beer_attrs
      desc = "#{beer_attrs["NOTES"]}\n\n" +
        "#{beer_attrs["PROFILE"]}\n\n" +
        "#{beer_attrs["INGREDIENTS"]}\n\n" +
        "#{beer_attrs["EXAMPLES"]}"
      write_attribute :description, desc
    end

    def combine_category_parts beer_attrs
      category = beer_attrs["CATEGORY"] + " - " +
        beer_attrs["CATEGORY_NUMBER"] + beer_attrs["STYLE_LETTER"]
      write_attribute :category, category
    end

end
