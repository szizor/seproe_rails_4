class CreateMainMigration < ActiveRecord::Migration
  def change
	  create_table "adopters", :force => true do |t|
	    t.string   "nombre"
	    t.string   "domicilio"
	    t.text     "giro"
	    t.string   "telefono"
	    t.string   "email"
	    t.text     "expectativas"
	    t.text     "interes"
	    t.integer  "user_id"
	    t.string   "url"
	    t.datetime "created_at",         :null => false
	    t.datetime "updated_at",         :null => false
	    t.string   "logo"
	    t.string   "acta"
	    t.string   "ife"
	    t.string   "razon"
	    t.string   "facebook_url"
	    t.string   "twitter_url"
	    t.integer  "desired_listing_id"
	    t.string   "alias"
	    t.string   "tipo"
	  end

	  create_table "adoption_requests", :force => true do |t|
	    t.integer  "adopter_id"
	    t.integer  "listing_id"
	    t.integer  "status"
	    t.datetime "created_at", :null => false
	    t.datetime "updated_at", :null => false
	  end

	  create_table "contacts", :force => true do |t|
	    t.string   "name"
	    t.string   "title"
	    t.string   "phone"
	    t.string   "cell"
	    t.string   "email"
	    t.integer  "adopter_id"
	    t.datetime "created_at", :null => false
	    t.datetime "updated_at", :null => false
	    t.string   "ife"
	  end

	  create_table "documents", :force => true do |t|
	    t.string   "title"
	    t.string   "file"
	    t.datetime "created_at", :null => false
	    t.datetime "updated_at", :null => false
	  end

	  create_table "events", :force => true do |t|
	    t.integer  "user_id"
	    t.datetime "start_date"
	    t.datetime "end_date"
	    t.integer  "listing_id"
	    t.string   "image"
	    t.boolean  "active"
	    t.text     "description"
	    t.datetime "created_at",  :null => false
	    t.datetime "updated_at",  :null => false
	    t.string   "name"
	  end

	  create_table "friendly_id_slugs", :force => true do |t|
	    t.string   "slug",                         :null => false
	    t.integer  "sluggable_id",                 :null => false
	    t.string   "sluggable_type", :limit => 40
	    t.datetime "created_at"
	  end

	  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
	  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
	  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

	  create_table "images", :force => true do |t|
	    t.string   "image"
	    t.integer  "listing_id"
	    t.integer  "user_id"
	    t.datetime "created_at", :null => false
	    t.datetime "updated_at", :null => false
	    t.boolean  "approved"
	  end

	  create_table "listing_types", :force => true do |t|
	    t.string   "name"
	    t.datetime "created_at", :null => false
	    t.datetime "updated_at", :null => false
	  end

	  create_table "listings", :force => true do |t|
	    t.string   "name"
	    t.decimal  "latitude",        :precision => 10, :scale => 8
	    t.decimal  "longitude",       :precision => 11, :scale => 8
	    t.string   "location"
	    t.boolean  "status"
	    t.integer  "adopter_id"
	    t.integer  "dimensions"
	    t.text     "description"
	    t.integer  "listing_type_id",                                :default => 1
	    t.datetime "created_at",                                                    :null => false
	    t.datetime "updated_at",                                                    :null => false
	    t.string   "subtitle"
	    t.integer  "postal"
	    t.string   "cover_image"
	    t.string   "slug"
	    t.datetime "adopted_at"
	    t.boolean  "is_featured"
	    t.string   "category"
	  end

	  add_index "listings", ["slug"], :name => "index_listings_on_slug", :unique => true

	  create_table "money", :force => true do |t|
	    t.integer  "user_id"
	    t.string   "amount"
	    t.datetime "created_at",  :null => false
	    t.datetime "updated_at",  :null => false
	    t.integer  "adopter_id"
	    t.integer  "listing_id"
	    t.text     "description"
	    t.datetime "spent_date"
	  end

	  create_table "photos", :force => true do |t|
	    t.integer  "user_id"
	    t.integer  "event_id"
	    t.string   "path"
	    t.datetime "created_at", :null => false
	    t.datetime "updated_at", :null => false
	  end

	  create_table "provider_categories", :force => true do |t|
	    t.string   "name"
	    t.string   "slug"
	    t.datetime "created_at", :null => false
	    t.datetime "updated_at", :null => false
	  end

	  create_table "providers", :force => true do |t|
	    t.string   "name"
	    t.string   "address"
	    t.string   "phone"
	    t.string   "facebook"
	    t.string   "twitter"
	    t.string   "email"
	    t.string   "website"
	    t.text     "description"
	    t.integer  "provider_category_id"
	    t.string   "slug"
	    t.datetime "created_at",           :null => false
	    t.datetime "updated_at",           :null => false
	  end

	  create_table "questions", :force => true do |t|
	    t.string   "title"
	    t.string   "questions"
	    t.text     "body"
	    t.integer  "user_id"
	    t.boolean  "status",     :default => false
	    t.datetime "created_at",                    :null => false
	    t.datetime "updated_at",                    :null => false
	    t.string   "slug"
	    t.boolean  "approved"
	  end

	  add_index "questions", ["slug"], :name => "index_questions_on_slug"

	  create_table "reports", :force => true do |t|
	    t.integer  "listing_id"
	    t.integer  "user_id"
	    t.string   "priority"
	    t.string   "photo"
	    t.text     "description"
	    t.string   "status"
	    t.datetime "created_at",                  :null => false
	    t.datetime "updated_at",                  :null => false
	    t.string   "report_type", :default => ""
	  end

	  create_table "responses", :force => true do |t|
	    t.integer  "question_id"
	    t.integer  "user_id"
	    t.text     "content"
	    t.datetime "created_at",  :null => false
	    t.datetime "updated_at",  :null => false
	    t.boolean  "approved"
	  end

	  create_table "rs_evaluations", :force => true do |t|
	    t.string   "reputation_name"
	    t.integer  "source_id"
	    t.string   "source_type"
	    t.integer  "target_id"
	    t.string   "target_type"
	    t.float    "value",           :default => 0.0
	    t.datetime "created_at",                       :null => false
	    t.datetime "updated_at",                       :null => false
	  end

	  add_index "rs_evaluations", ["reputation_name", "source_id", "source_type", "target_id", "target_type"], :name => "index_rs_evaluations_on_reputation_name_and_source_and_target", :unique => true
	  add_index "rs_evaluations", ["reputation_name"], :name => "index_rs_evaluations_on_reputation_name"
	  add_index "rs_evaluations", ["source_id", "source_type"], :name => "index_rs_evaluations_on_source_id_and_source_type"
	  add_index "rs_evaluations", ["target_id", "target_type"], :name => "index_rs_evaluations_on_target_id_and_target_type"

	  create_table "rs_reputation_messages", :force => true do |t|
	    t.integer  "sender_id"
	    t.string   "sender_type"
	    t.integer  "receiver_id"
	    t.float    "weight",      :default => 1.0
	    t.datetime "created_at",                   :null => false
	    t.datetime "updated_at",                   :null => false
	  end

	  add_index "rs_reputation_messages", ["receiver_id", "sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_receiver_id_and_sender", :unique => true
	  add_index "rs_reputation_messages", ["receiver_id"], :name => "index_rs_reputation_messages_on_receiver_id"
	  add_index "rs_reputation_messages", ["sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_sender_id_and_sender_type"

	  create_table "rs_reputations", :force => true do |t|
	    t.string   "reputation_name"
	    t.float    "value",           :default => 0.0
	    t.string   "aggregated_by"
	    t.integer  "target_id"
	    t.string   "target_type"
	    t.boolean  "active",          :default => true
	    t.datetime "created_at",                        :null => false
	    t.datetime "updated_at",                        :null => false
	  end

	  add_index "rs_reputations", ["reputation_name", "target_id", "target_type"], :name => "index_rs_reputations_on_reputation_name_and_target", :unique => true
	  add_index "rs_reputations", ["reputation_name"], :name => "index_rs_reputations_on_reputation_name"
	  add_index "rs_reputations", ["target_id", "target_type"], :name => "index_rs_reputations_on_target_id_and_target_type"

	  create_table "videos", :force => true do |t|
	    t.integer  "user_id"
	    t.string   "url"
	    t.integer  "listing_id"
	    t.datetime "created_at", :null => false
	    t.datetime "updated_at", :null => false
	    t.string   "title"
	  end
  end
end
