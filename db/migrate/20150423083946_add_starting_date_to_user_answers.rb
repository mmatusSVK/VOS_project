class AddStartingDateToUserAnswers < ActiveRecord::Migration
  def change
    add_column :user_answers, :starting_date, :datetime
  end
end
