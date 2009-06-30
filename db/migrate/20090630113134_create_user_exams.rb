class CreateUserExams < ActiveRecord::Migration
  def self.up
    create_table :user_exams do |t|
      t.integer :user_id
      t.integer :exam_id
      t.timestamps :finished_at
      t.timestamps
    end
  end

  def self.down
    drop_table :user_exams
  end
end
