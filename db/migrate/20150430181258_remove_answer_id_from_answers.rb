class RemoveAnswerIdFromAnswers < ActiveRecord::Migration
  def up
    remove_foreign_key :user_answers, :answers
    remove_column :user_answers, :answer_id
  end

  def down
    add_column :user_answers, :answer_id, :integer
    add_foreign_key :user_answers, :answers
  end
end
