ActiveRecord::Schema.define(:version => 0) do
  create_table :unusual_beer_styles, :force => true do |t|
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

  create_table :beer_styles, :force => true do |t|
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
end
