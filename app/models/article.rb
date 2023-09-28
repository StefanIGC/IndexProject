class Article < ApplicationRecord
  validates :title , presence: true, length: { minimum: 5, maximum: 20 }
  validates :description, presence: true, length: { minimum: 10, maximum: 200 }

  belongs_to :author, class_name: 'User'
  belongs_to :category
  has_many :comments
  has_and_belongs_to_many :tags
end
