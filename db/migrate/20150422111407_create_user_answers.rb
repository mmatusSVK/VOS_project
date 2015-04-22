class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.integer :test_id
      t.integer :answer_id
      t.integer :student_id
      t.boolean :answer_value
      t.timestamps null: false
    end
    add_foreign_key :user_answers, :tests
    add_foreign_key :user_answers, :answers
  end
end
