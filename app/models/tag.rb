class Tag < ApplicationRecord
  validates :tag, presence: true
  validates :tag, uniqueness: true
  validates :tag, length: { maximum: 15, message: "the maximum length is 15." }
  validates :tag, format: { with: /\A[0-9a-zA-Z]+\z/, message: "can only contain letters, numbers, or both." }

  has_and_belongs_to_many :tweets

  def times_used
    self.tweets.count
  end

  def self.get_all_tags_ordered_by_popularity
    Tag.all.sort_by(&:times_used).reverse!
  end
end
