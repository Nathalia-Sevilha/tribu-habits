class Community < ApplicationRecord
  has_many :habits
  has_many :users, through: :habits
  has_many :posts
end
