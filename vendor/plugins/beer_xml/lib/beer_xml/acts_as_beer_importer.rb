module BeerXml
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_beer_importer type
      cattr_accessor :beer_importer_type
      self.beer_importer_type = type
      send :include, InstanceMethods
    end

    def import_from_hash attr_hash
      beer_style = self.new
      beer_style.load_defaults attr_hash
      beer_style
    end

    def import_beer_xml filename
      @importer ||= BeerXml::Importer.new
      @importer.import filename
      @importer.send self.beer_importer_type
    end

  end

  module InstanceMethods
=begin
        beer_style = ::BeerStyle.new
        beer_style.name = hash_map["NAME"]
        beer_style.description = "#{hash_map["NOTES"]}\n#{hash_map["PROFILE"]}"
        beer_style.category = hash_map["CATEGORY"]
        beer_style
=end
    def load_defaults attr_hash
      attr_hash.each do |attr_key, attr_value|
        style_attr = attr_key.downcase
        begin
          send "#{style_attr}=", attr_value
        rescue NoMethodError
          # Check for a provided override
        end
      end
    end

  end
end

ActiveRecord::Base.send :include, BeerXml
