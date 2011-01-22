require 'nokogiri'

module BeerXml
  class Reader

    def initialize(xml)
      raise ArgumentError if xml.nil?
      @document = Nokogiri::XML(xml)
    end

    def styles
      @parsed_styles ||= @document.xpath("//STYLE").collect { |style| parse_style(style) }
    end

    protected
      def parse_style (style)
         keys = style.elements.collect { |element| element.name }
         values = style.elements.collect { |element| element.text }
         Hash[keys.zip(values)]
      end
  end
end
