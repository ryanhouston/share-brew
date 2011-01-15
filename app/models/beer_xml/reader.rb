require 'nokogiri'

module BeerXml
  class Reader

    def initialize(xml = nil)
      @_xml = xml
      @_document = nil
    end

    def styles
      parsed_styles = []
      document.xpath("//STYLE").each do |style|
        parsed_styles << parse_style(style)
      end
      parsed_styles
    end

    def parse_style (style)
      parsed_style = Hash.new
      style.elements.each do |element|
        parsed_style[element.name] = element.text
      end
      parsed_style
    end

    protected
    def document
      if @_document.nil?
        @_document = Nokogiri::XML(@_xml)
      end
      @_document
    end

  end
end
