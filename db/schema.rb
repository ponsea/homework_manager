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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170118003252) do

  create_table "grades", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",             limit: 40, null: false
    t.integer  "group_id",                    null: false
    t.integer  "necessary_points",            null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["group_id", "necessary_points"], name: "index_grades_on_group_id_and_necessary_points", unique: true, using: :btree
    t.index ["group_id"], name: "index_grades_on_group_id", using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       limit: 40,                    null: false
    t.text     "detail",     limit: 65535
    t.boolean  "private",                  default: false, null: false
    t.string   "password",   limit: 40
    t.integer  "author_id",                                null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["author_id"], name: "index_groups_on_author_id", using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",       limit: 65535, null: false
    t.integer  "user_id"
    t.integer  "group_id",                 null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["group_id"], name: "index_messages_on_group_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",      limit: 120,               null: false
    t.text     "detail",     limit: 65535
    t.datetime "deadline"
    t.integer  "points",     limit: 2
    t.integer  "importance", limit: 1,     default: 3, null: false
    t.integer  "author_id",                            null: false
    t.integer  "group_id",                             null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["author_id"], name: "index_tasks_on_author_id", using: :btree
    t.index ["group_id"], name: "index_tasks_on_group_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email",               null: false
    t.string "password", limit: 64, null: false
    t.string "salt",     limit: 16, null: false
    t.string "name",     limit: 30, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  create_table "users_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id",                  null: false
    t.integer "group_id",                 null: false
    t.boolean "admin",    default: false, null: false
    t.index ["group_id"], name: "index_users_groups_on_group_id", using: :btree
    t.index ["user_id", "group_id"], name: "index_users_groups_on_user_id_and_group_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_users_groups_on_user_id", using: :btree
  end

  create_table "users_tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",     null: false
    t.integer  "task_id",     null: false
    t.datetime "finished_at"
    t.index ["task_id"], name: "index_users_tasks_on_task_id", using: :btree
    t.index ["user_id", "task_id"], name: "index_users_tasks_on_user_id_and_task_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_users_tasks_on_user_id", using: :btree
  end

  add_foreign_key "grades", "groups"
  add_foreign_key "groups", "users", column: "author_id"
  add_foreign_key "messages", "groups"
  add_foreign_key "messages", "users"
  add_foreign_key "tasks", "groups"
  add_foreign_key "tasks", "users", column: "author_id"
  add_foreign_key "users_groups", "groups"
  add_foreign_key "users_groups", "users"
  add_foreign_key "users_tasks", "tasks"
  add_foreign_key "users_tasks", "users"
end
