# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101210204305) do

  create_table "beer_styles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.boolean  "lager",                                         :default => false
    t.decimal  "min_orig_grav",   :precision => 5, :scale => 4
    t.decimal  "max_orig_grav",   :precision => 5, :scale => 4
    t.decimal  "min_final_grav",  :precision => 5, :scale => 4
    t.decimal  "max_final_grav",  :precision => 5, :scale => 4
    t.decimal  "min_IBUs",        :precision => 4, :scale => 2
    t.decimal  "max_IBUs",        :precision => 4, :scale => 2
    t.float    "min_color"
    t.float    "max_color"
    t.float    "min_carbonation"
    t.float    "max_carbonation"
    t.float    "min_abv"
    t.float    "max_abv"
  end

  create_table "fermentables", :force => true do |t|
    t.string   "name"
    t.string   "origin"
    t.string   "vendor"
    t.string   "form"
    t.float    "color"
    t.decimal  "potential",    :precision => 5, :scale => 4
    t.float    "yield"
    t.float    "max_in_batch"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hops", :force => true do |t|
    t.string   "name"
    t.string   "typical_use"
    t.decimal  "alpha_acid",  :precision => 4, :scale => 2
    t.decimal  "beta_acid",   :precision => 4, :scale => 2
    t.string   "origin"
    t.string   "form"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "ingredient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_ingredients", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.string   "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", :force => true do |t|
    t.string   "name",             :null => false
    t.string   "mash_type",        :null => false
    t.text     "description"
    t.string   "batch_size"
    t.string   "original_gravity"
    t.string   "final_gravity"
    t.string   "bitterness"
    t.string   "color"
    t.text     "procedure"
    t.integer  "beer_style_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yeasts", :force => true do |t|
    t.string   "vendor"
    t.string   "strain"
    t.string   "catalog_id"
    t.string   "form"
    t.text     "description"
    t.boolean  "use_starter"
    t.integer  "min_temp"
    t.integer  "max_temp"
    t.float    "attenuation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
