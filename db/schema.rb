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

ActiveRecord::Schema.define(:version => 20130106211809) do

  create_table "products", :force => true do |t|
    t.string   "title"
    t.string   "price"
    t.text     "description"
    t.text     "details"
    t.string   "brand"
    t.string   "model_number"
    t.string   "external_id"
    t.string   "external_url"
    t.string   "external_provider"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "products", ["external_id"], :name => "index_products_on_external_id"
  add_index "products", ["external_provider"], :name => "index_products_on_external_provider"
  add_index "products", ["price"], :name => "index_products_on_price"
  add_index "products", ["title"], :name => "index_products_on_title"

end
