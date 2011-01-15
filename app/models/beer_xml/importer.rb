module BeerXml
  class UninitializedReaderError < RuntimeError
  end

  class Importer
    def import(filename)
      raise ArgumentError if filename.nil?
      @current_file = filename
    end

    def reader
      raise UninitializedReaderError if @current_file.nil?
      @reader ||= BeerXml::Reader.new(File.new(@current_file))
    end

    def styles
      @styles ||= reader.styles.collect { |style| BeerXml::Import::BeerStyle.fromHashMap style }
    end
  end
end
