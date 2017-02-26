class User < ApplicationRecord
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, length: { maximum: 50, message: "the maximum length is 50." }
  validates :email, format: { with: /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+\z/, message: "must have a valid email format." }

  validates :username, presence: true
  validates :username, length: { maximum: 30, message: "the maximum length is 30." }
  validates :username, format: { with: /\A[0-9a-zA-Z]+\z/, message: "can only contain letters, numbers, or both." }

  has_many :tweets
end
