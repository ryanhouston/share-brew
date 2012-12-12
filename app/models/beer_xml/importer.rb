module BeerXml
  class UninitializedReaderError < RuntimeError
  end

  class Importer
    def import( filename )
      raise ArgumentError if filename.nil?
      reset_importer
      @current_file = filename
    end

    def self.logger
      Rails.logger
    end

    def self.import_and_save!( filename )
      importer = BeerXml::Importer.new
      importer.import(filename)

      importer.styles(BeerStyle).each do |style|
        logger.info "Importing BeerStyle: #{style.name}"
        style.save!
      end

      importer.hops(Hop).each do |hop|
        logger.info "Importing Hop: #{hop.name}"
        hop.save!
      end

      importer.fermentables(Fermentable).each do |fermentable|
        logger.info "Importing Fermentable: #{fermentable.name}"
        fermentable.save!
      end

      importer.yeasts(Yeast).each do |yeast|
        logger.info "Importing Yeast: #{yeast.strain}"
        yeast.save!
      end
    end

    def reset_importer
      @styles = nil
      @hops = nil
      @reader = nil
      @current_file = nil
    end

    def reader
      raise UninitializedReaderError if @current_file.nil?
      @reader ||= BeerXml::Reader.new(File.new(@current_file))
    end

    def styles( klass )
      @styles ||= reader.styles.collect do |style|
        klass.import_from_hash style
      end
    end

    def hops( klass )
      @hops ||= reader.hops.collect do |hop|
        klass.import_from_hash hop
      end
    end

    def fermentables( klass )
      @fermentables ||= reader.fermentables.collect do |fermentable|
        klass.import_from_hash fermentable
      end
    end

    def yeasts( klass )
      @yeasts ||= reader.yeasts.collect do |yeast|
        klass.import_from_hash yeast
      end
    end
  end
end
