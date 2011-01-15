module BeerXml
  class UninitializedReaderError < RuntimeError
  end

  class Importer
    def initialize(beer_xml = nil)
      unless beer_xml.nil?
        @_beer_xml = beer_xml
      end
    end

    def reader
      if @_reader.nil?
        if @_beer_xml.nil?
          raise UninitializedReaderError
        end
        xml = File.new(@_beer_xml)
        @_reader = BeerXml::Reader.new(xml)
      end
      @_reader
    end

    def styles
      imported_styles = Array.new
      hashed_styles = reader.styles
      hashed_styles.each do |style_hash|
        beer_style = BeerXml::Import::BeerStyle.fromHashMap style_hash
        imported_styles << beer_style
      end
      imported_styles
    end

  end
end
