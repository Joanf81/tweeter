class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.text :text
      t.string :url

      t.string :type # Inheritance
      t.belongs_to :user, index: true # 1-1 Association with user

      t.timestamps
    end
  end
end
