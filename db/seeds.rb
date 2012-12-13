# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

admin = User.create({ email: 'admin@sharebrew.com',
                      password: 'password',
                      name: 'Admin',
                      admin: true,
                      confirmed_at: Time.now
                    }, without_protection: true)

beer_xml_seed_files = %w(
  spec/fixtures/bjcp-2008-styles.xml
  spec/fixtures/grain.xml
  spec/fixtures/hops.xml
  spec/fixtures/yeast.xml)

beer_xml_seed_files.each do |seed_file|
  BeerXml::Importer.import_and_save!(Rails.root + seed_file)
end

