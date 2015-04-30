class AddTopicIdQuestionIdToUserAnswers < ActiveRecord::Migration
  def up
    add_column :user_answers, :topic_id, :integer
    add_column :user_answers, :question_id, :integer
    add_foreign_key :user_answers, :questions
    add_foreign_key :user_answers, :topics
  end

  def down
    remove_foreign_key :user_answers, :questions
    remove_foreign_key :user_answers, :topics
    remove_column(:user_answers, :topic_id)
    remove_column(:user_answers, :question_id)
  end
end
