class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.int :exam_id
      t.text :question
      t.string :type
      t.text :answer_1
      t.text :answer_2
      t.text :answer_3
      t.text :answer_4
      t.text :answer_5
      t.text :answers_list
      t.timestamps
    end

    add_index(:question, :exam_id)
  end

  def self.down
    drop_table :questions
  end
end
