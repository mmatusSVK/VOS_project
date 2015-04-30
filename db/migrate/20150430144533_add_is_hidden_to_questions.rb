class AddIsHiddenToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :is_hidden, :boolean
  end
end
