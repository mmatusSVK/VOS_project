class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question_name
      t.integer :topic_id
      t.timestamps null: false
    end
    add_foreign_key :questions, :topics
  end
end
