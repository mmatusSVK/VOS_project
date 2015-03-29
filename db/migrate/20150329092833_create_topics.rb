class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|

      t.string :topic_name
      t.integer :user_id
      t.timestamps null: false

    end

    add_foreign_key :topics, :users
  end
end
