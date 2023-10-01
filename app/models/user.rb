class User < ApplicationRecord
  enum role: %i[user admin]
  after_initialize :set_default_role, if: :new_record?

  has_many :articles, foreign_key: 'author'
  has_many :comments


  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  devise :database_authenticatable, :registerable, :validatable, :lockable,
         :jwt_authenticatable, jwt_revocation_strategy: self
        


        def set_default_role
          self.role ||= :user
        end
end
