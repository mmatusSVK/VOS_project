class QuestionsQuestionNameChangeType < ActiveRecord::Migration
  def up
    change_column(:questions, :question_name, :text, :null => false)
  end

  def down
    change_column(:questions, :question_name, :string, :null => true)
  end
end
