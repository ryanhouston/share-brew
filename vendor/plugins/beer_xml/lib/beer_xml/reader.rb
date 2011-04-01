require 'nokogiri'

module BeerXml
  class Reader

    def initialize(xml)
      raise ArgumentError if xml.nil?
      @document = Nokogiri::XML(xml)
    end

    def styles
      @parsed_styles ||= @document.xpath("//STYLE").collect { |style| parse_element(style) }
    end

    def hops
      @parsed_hops ||= @document.xpath("//HOP").collect { |hop| parse_element(hop) }
    end

    def fermentables
      @fermentables ||= @document.xpath("//FERMENTABLE").collect{ |fermentable| parse_element(fermentable) }
    end

    protected
      def parse_element (beer_element)
         keys = beer_element.elements.collect { |element| element.name }
         values = beer_element.elements.collect { |element| element.text }
         Hash[keys.zip(values)]
      end
  end
end
