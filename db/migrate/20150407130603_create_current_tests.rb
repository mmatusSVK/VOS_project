class CreateCurrentTests < ActiveRecord::Migration
  def change
    create_table :current_tests do |t|
      t.integer :topic_id
      t.integer :test_id
      t.integer :questions_count
      t.timestamps null: false
    end
    add_foreign_key :current_tests, :topics
    add_foreign_key :current_tests, :tests
  end
end
