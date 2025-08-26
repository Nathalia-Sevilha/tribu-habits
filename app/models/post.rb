class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community

  validades :title, presence: true
  validates :content, presence: true
end
