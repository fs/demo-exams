class CreateExams < ActiveRecord::Migration
  def self.up
    create_table :exams do |t|
      t.string :name
      t.text :description
<<<<<<< HEAD:db/migrate/20090630101715_create_exams.rb
      t.integer :question_count
      t.integer :time_limit
=======
      t.int :question_count
      t.int :time_limit
>>>>>>> 0243f72309e5cc992e9fb1520ce08c021956ae60:db/migrate/20090630101715_create_exams.rb

      t.timestamps
    end
  end

  def self.down
    drop_table :exams
  end
end
