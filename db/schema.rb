# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121201010617) do

  create_table "beer_styles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.string   "category"
    t.boolean  "lager",                                         :default => false
    t.decimal  "min_orig_grav",   :precision => 5, :scale => 4
    t.decimal  "max_orig_grav",   :precision => 5, :scale => 4
    t.decimal  "min_final_grav",  :precision => 5, :scale => 4
    t.decimal  "max_final_grav",  :precision => 5, :scale => 4
    t.decimal  "min_IBUs",        :precision => 5, :scale => 2
    t.decimal  "max_IBUs",        :precision => 5, :scale => 2
    t.float    "min_color"
    t.float    "max_color"
    t.float    "min_carbonation"
    t.float    "max_carbonation"
    t.float    "min_abv"
    t.float    "max_abv"
  end

  create_table "fermentable_additions", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "fermentable_id"
    t.decimal  "weight"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "fermentable_additions", ["fermentable_id"], :name => "index_fermentable_additions_on_fermentable_id"
  add_index "fermentable_additions", ["recipe_id"], :name => "index_fermentable_additions_on_recipe_id"

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
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "hop_additions", :force => true do |t|
    t.integer  "hop_id"
    t.integer  "recipe_id"
    t.decimal  "alpha_acid", :precision => 4, :scale => 2, :null => false
    t.decimal  "beta_acid",  :precision => 4, :scale => 2
    t.decimal  "weight",                                   :null => false
    t.string   "form",                                     :null => false
    t.integer  "duration",                                 :null => false
    t.string   "use",                                      :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "hop_additions", ["hop_id"], :name => "index_hop_additions_on_hop_id"

  create_table "hops", :force => true do |t|
    t.string   "name"
    t.string   "typical_use"
    t.decimal  "alpha_acid",  :precision => 4, :scale => 2
    t.decimal  "beta_acid",   :precision => 4, :scale => 2
    t.string   "origin"
    t.string   "form"
    t.text     "notes"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "recipes", :force => true do |t|
    t.string   "name",                             :null => false
    t.string   "mash_type",                        :null => false
    t.text     "description"
    t.string   "batch_size"
    t.string   "original_gravity"
    t.string   "final_gravity"
    t.text     "procedure"
    t.integer  "beer_style_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "user_id"
    t.integer  "boil_length",      :default => 60, :null => false
    t.decimal  "mash_efficiency"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                         :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.boolean  "admin",                                 :default => false
    t.string   "name"
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "yeast_additions", :force => true do |t|
    t.boolean  "use_starter"
    t.integer  "starter_size"
    t.integer  "yeast_id"
    t.integer  "recipe_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "yeast_additions", ["recipe_id"], :name => "index_yeast_additions_on_recipe_id"
  add_index "yeast_additions", ["yeast_id"], :name => "index_yeast_additions_on_yeast_id"

  create_table "yeasts", :force => true do |t|
    t.string   "vendor"
    t.string   "strain"
    t.string   "catalog_id"
    t.string   "form"
    t.text     "description"
    t.float    "attenuation"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "flocculation"
    t.string   "strain_type"
    t.float    "min_temp"
    t.float    "max_temp"
  end

end
