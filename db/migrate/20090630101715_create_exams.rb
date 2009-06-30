class CreateExams < ActiveRecord::Migration
  def self.up
    create_table :exams do |t|
      t.string :name
      t.text :description
      t.int :question_count
      t.int :time_limit

      t.timestamps
    end
  end

  def self.down
    drop_table :exams
  end
end
