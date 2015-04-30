class AddIsHiddenToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :is_hidden, :boolean
  end
end
