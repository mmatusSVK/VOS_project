class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.string :answer_name
      t.boolean :is_right
      t.timestamps null: false
    end
    add_foreign_key :answers, :questions
  end
end
