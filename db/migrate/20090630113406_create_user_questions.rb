class CreateUserQuestions < ActiveRecord::Migration
  def self.up
    create_table :user_questions do |t|
      t.integer :user_exam_id
      t.integer :question_id
      t.boolean :correct
      t.timestamps
    end
  end

  def self.down
    drop_table :user_questions
  end
end
