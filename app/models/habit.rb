class Habit < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_many :day_habits, dependent: :destroy
  has_many :days, through: :day_habits
  accepts_nested_attributes_for :day_habits, allow_destroy: true
  validates :title, presence: true, uniqueness: { scope: :user }
  validates :streak, numericality: { greater_than_or_equal_to: 0 }
end
