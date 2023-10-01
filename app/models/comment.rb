class Comment < ApplicationRecord
  validates :content, presence: true, length: { minimum: 10, maximum: 200 }
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :article
end
