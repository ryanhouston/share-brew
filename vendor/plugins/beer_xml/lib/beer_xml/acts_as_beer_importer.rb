module BeerXml
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_beer_importer type, options = nil
      cattr_accessor :beer_importer_type, :attr_map
      self.beer_importer_type = type
      self.attr_map = options[:translated_as] if !options.nil?
      send :include, InstanceMethods
    end

    def import_from_hash style_hash
      beer_style = self.new
      beer_style.load_defaults style_hash
      beer_style
    end

    def import_beer_xml filename
      # TODO: Pass self.attr_map to Importer
      # TODO: Importer needs ref to target class type
      @importer ||= BeerXml::Importer.new
      @importer.import filename
      @importer.send self.beer_importer_type, self
    end

  end

  module InstanceMethods
    def load_defaults style_hash
      style_hash.each do |attr_key, attr_value|
        style_attr = attr_key.downcase
        begin
          send "#{style_attr}=", attr_value
        rescue NoMethodError
          # Check for a provided override
          if !self.attr_map.nil? && !self.attr_map[style_attr.to_sym].nil?
            mapped_attr = self.attr_map[style_attr.to_sym]
            logger.info "Mapping beer XML <#{style_attr}> to [#{mapped_attr}]\n"
            send "#{mapped_attr}=", attr_value
          else
            logger.info "No mapping for #{style_attr}\n"
          end
        end
      end
    end

  end
end

ActiveRecord::Base.send :include, BeerXml
