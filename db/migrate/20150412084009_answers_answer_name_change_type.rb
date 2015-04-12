class AnswersAnswerNameChangeType < ActiveRecord::Migration
  def up
    change_column(:answers, :answer_name, :text, :null => false)
  end

  def down
    change_column(:answers, :answer_name, :string, :null => true)
  end
end
