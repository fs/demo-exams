class CreateExams < ActiveRecord::Migration
  def self.up
    create_table :exams do |t|
      t.string :name
      t.text :description
      t.integer :question_count
      t.integer :time_limit

      t.timestamps
    end
  end

  def self.down
    drop_table :exams
  end
end
