class AddFieldsToBeerStyles < ActiveRecord::Migration
  def up
    add_column :beer_styles, :style_id, :string
    add_column :beer_styles, :style_type, :string

    # Re-import beer styles
    BeerStyle.destroy_all
    BeerXml::Importer.import_and_save!(
      Rails.root + 'spec/fixtures/bjcp-2008-styles.xml')
  end

  def down
    #remove_column :beer_styles, :style_id
    #remove_column :beer_styles, :type
    # Cannot rollback due to destructive data migration
    raise ActiveRecord::IrreversibleMigration, "This migration cannot be reversed due to modifications to the beer style import format. Please make the necessary schema changes, modify the beer_xml import strategy, and re-import the BJCP style guide"
  end
end
