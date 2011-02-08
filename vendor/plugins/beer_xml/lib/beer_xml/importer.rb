module BeerXml
  class UninitializedReaderError < RuntimeError
  end

  class Importer
    def import(filename)
      raise ArgumentError if filename.nil?
      reset_importer
      @current_file = filename
    end

    def reset_importer
      @styles = nil
      @reader = nil
      @current_file = nil
    end

    def reader
      raise UninitializedReaderError if @current_file.nil?
      @reader ||= BeerXml::Reader.new(File.new(@current_file))
    end

    def styles klass
      @styles ||= reader.styles.collect do |style|
        klass.import_from_hash style
      end
    end

    def hops klass
      @hops ||= reader.hops.collect do |hop|
        klass.import_from_hash hop
      end
    end

  end
end
