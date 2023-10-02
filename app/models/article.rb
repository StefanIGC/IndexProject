class Article < ApplicationRecord

  acts_as_paranoid
  validates :title , presence: true, length: { minimum: 5, maximum: 50 }
  validates :description, presence: true, length: { minimum: 5, maximum: 300 }

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags

  include PgSearch::Model
  pg_search_scope :search_by_words, against: %i[ title description created_at ],
                                    associated_against: {
                                       author: %i[first_name last_name], 
                                       category: %i[name]
                                     }
end
