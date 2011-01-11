require 'rexml/document'
include REXML

module BeerXml
  class BeerXml::Parser

    def initialize(xml = nil)
      @_xml = xml
      @_document = nil
    end

    def styles
      parsed_styles = []
      document.elements.each("STYLES/STYLE") do |style|
        parsed_styles << parse_style(style)
      end
      parsed_styles
    end

    def parse_style (style)
      parsed_style = style.elements
      style.elements.each do |elem|
        puts "Elem: " + elem.name + " => " + elem.text
      end
      parsed_style
    end

    protected
    def document
      if @_document.nil?
        @_document = Document.new(@_xml)
        puts @_document.inspect
      end
      @_document
    end

  end
end
