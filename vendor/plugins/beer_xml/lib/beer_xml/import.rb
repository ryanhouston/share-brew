module BeerXml
  module Import

    def self.fromHashMap hash_map
    end

    class BeerStyle
      def self.fromHashMap hash_map
        beer_style = ::BeerStyle.new
        beer_style.name = hash_map["NAME"]
        beer_style.description = "#{hash_map["NOTES"]}\n#{hash_map["PROFILE"]}"
        beer_style.category = hash_map["CATEGORY"]
        beer_style
      end
    end

  end
end
