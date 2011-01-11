require 'test_helper'

class BeerXml::ParserTest < ActiveSupport::TestCase

  context "a Beer XML Parser" do
    setup do
      @beer_xml_parser = BeerXml::Parser.new
    end

    should "be a valid Parser" do
      assert @beer_xml_parser.instance_of?(BeerXml::Parser), "Class Found #{@beer_xml_parser.class}"
    end
  end

  context "Given a valid BeerXml file, the Parser" do
    setup do
      @beer_styles_file = Rails.root.to_s + '/test/unit/beer_xml/beer_styles.xml'
      file = File.new(@beer_styles_file)
      @beer_xml_parser = BeerXml::Parser.new(file)
    end

    should "return an array of parsed styles" do
      styles = @beer_xml_parser.styles
      assert (styles.kind_of? Array)
    end

  end

end
