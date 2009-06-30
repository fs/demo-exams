class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
<<<<<<< HEAD:db/migrate/20090630102435_create_questions.rb
      t.integer :exam_id
=======
      t.int :exam_id
>>>>>>> 0243f72309e5cc992e9fb1520ce08c021956ae60:db/migrate/20090630102435_create_questions.rb
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

<<<<<<< HEAD:db/migrate/20090630102435_create_questions.rb
    add_index(:questions, :exam_id)
=======
    add_index(:question, :exam_id)
>>>>>>> 0243f72309e5cc992e9fb1520ce08c021956ae60:db/migrate/20090630102435_create_questions.rb
  end

  def self.down
    drop_table :questions
  end
end
