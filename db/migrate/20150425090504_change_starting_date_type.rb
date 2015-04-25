class ChangeStartingDateType < ActiveRecord::Migration
  def up
    change_column(:user_answers, :starting_date, :string)
  end

  def down
    change_column(:user_answers, :starting_date, :datetime)
  end
end
