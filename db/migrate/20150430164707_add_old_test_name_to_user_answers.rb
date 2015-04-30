class AddOldTestNameToUserAnswers < ActiveRecord::Migration
  def change
    add_column :user_answers, :old_test_name, :text
  end
end
