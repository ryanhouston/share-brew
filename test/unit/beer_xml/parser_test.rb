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

  context "Given a valid BeerXml file of beer style data, the Parser" do
    setup do
      @beer_styles = load_beer_styles
    end

    should "return an array of parsed styles" do
      styles = @beer_styles
      assert (styles.kind_of? Array)
    end

    should "return style data as a hash map" do
      style = @beer_styles.first
      assert (style.kind_of? Hash)
	end
  end

  context "Given a parsed BeerXml Beer Style" do
    setup do
      @beer_style = load_beer_styles.first
    end

    should "have a Name attribute" do
      assert_not_nil(@beer_style['NAME'], "Beer style NAME attribute is nil")
      assert_equal('American Amber Ale', @beer_style['NAME'])
    end
  end

  def load_beer_styles
    @beer_styles_file = Rails.root.to_s + '/test/unit/beer_xml/beer_styles.xml'
    file = File.new(@beer_styles_file)
    @beer_xml_parser = BeerXml::Parser.new(file)
    @beer_xml_parser.styles
  end


end
