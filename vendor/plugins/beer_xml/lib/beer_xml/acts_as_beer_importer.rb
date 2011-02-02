module BeerXml
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_beer_importer_of type, options = nil
      cattr_accessor :beer_importer_type, :attr_map, :translate_callbacks
      self.beer_importer_type = type
      self.attr_map = options[:translated_as] if options
      self.translate_callbacks = options[:using] if options
      send :include, InstanceMethods
    end

    def import_from_hash style_hash
      beer_style = self.new
      beer_style.load_defaults style_hash
      beer_style.run_translation_callbacks(style_hash) if self.translate_callbacks
      beer_style
    end

    def import_beer_xml filename
      @importer ||= BeerXml::Importer.new
      @importer.import filename
      @importer.send self.beer_importer_type, self
    end

  end

  module InstanceMethods
    def load_defaults style_hash
      style_hash.each do |attr_key, attr_value|
        style_attr = attr_key.downcase
        attempt_set_attr style_attr, attr_value
      end
    end

  private
    def attempt_set_attr style_attr, attr_value
      begin
        send "#{style_attr}=", attr_value
      rescue NoMethodError
        load_override_if_provided(style_attr, attr_value)
      end
    end

    def load_override_if_provided style_attr, attr_value
      if !self.attr_map.nil? && !self.attr_map[style_attr.to_sym].nil?
        mapped_attr = self.attr_map[style_attr.to_sym]
        logger.debug "Mapping beer XML <#{style_attr}> to [#{mapped_attr}]\n"
        send "#{mapped_attr}=", attr_value
      else
        logger.debug "No override mapping for #{style_attr}\n"
      end
    end

  public
    def run_translation_callbacks style_hash
      self.translate_callbacks.each do |model_attr, model_method|
        translated_value = send model_method, style_hash
        send "#{model_attr}=", translated_value
      end
    end

  end
end

ActiveRecord::Base.send :include, BeerXml
