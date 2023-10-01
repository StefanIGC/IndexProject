class Article < ApplicationRecord
  acts_as_paranoid
  validates :title , presence: true, length: { minimum: 5, maximum: 50 }
  validates :description, presence: true, length: { minimum: 5, maximum: 300 }

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
end
