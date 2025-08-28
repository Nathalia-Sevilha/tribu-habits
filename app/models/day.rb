class Day < ApplicationRecord
  has_many :day_habits, dependent: :destroy
  has_many :habits, through: :day_habits
  validates :name, presence: true, uniqueness: true
end
