require File.expand_path('../../../config/environment', __FILE__)
require 'beer_xml'

namespace :beer_xml do
  desc "Import a BeerSmith 1.x xml file"
  task :import do
    file_path = File.expand_path(ENV['file'])
    puts "Attempting to import BeerSmith 1.x XML file: #{file_path}"
    importer = BeerXml::Importer.import_and_save!(file_path)
  end
end

