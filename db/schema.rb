# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090630113406) do

  create_table "exams", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "question_count"
    t.integer  "time_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "exam_id"
    t.text     "question"
    t.string   "question_type"
    t.text     "answer_1"
    t.text     "answer_2"
    t.text     "answer_3"
    t.text     "answer_4"
    t.text     "answer_5"
    t.text     "answers_list"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["exam_id"], :name => "index_questions_on_exam_id"

  create_table "user_answers", :force => true do |t|
    t.integer  "user_exam_id"
    t.integer  "question_id"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_exams", :force => true do |t|
    t.integer  "user_id"
    t.integer  "exam_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
