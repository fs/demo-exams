class CreateUserAnswers < ActiveRecord::Migration
  def self.up
    create_table :user_answers do |t|
      t.int :user_exam_id
      t.int :question_id
      t.bool :correct

      t.timestamps
    end
  end

  def self.down
    drop_table :user_answers
  end
end
