class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :test_name
      t.integer :user_id
      t.timestamps null: false
    end
    add_foreign_key :tests, :users
  end
end
