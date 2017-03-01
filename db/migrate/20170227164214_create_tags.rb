class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :tag

      t.timestamps
    end

    create_table :tags_tweets, id: false do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :tweet, index: true
    end
  end
end
