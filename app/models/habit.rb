class Habit < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_many :day_habits, dependent: :destroy
  has_many :days, through: :day_habits
  validates :title, presence: true, uniqueness: true
  validates :streak, numericality: { greater_than_or_equal_to: 0 }
end
