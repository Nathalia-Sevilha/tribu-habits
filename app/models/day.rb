class Day < ApplicationRecord
  has_many :day_habits, dependent: :destroy
  has_many :habits, through: :day_habits
  validates :name, presence: true, uniqueness: true
  # Returns DayHabit records for this day and user
  def habits_for_user(user)
    day_habits.joins(:habit).where(habits: { user_id: user.id })
  end

  # Returns count of completed habits for this day and user
  def completed_habits_count(user)
    habits_for_user(user).where(done: true).count
  end

  # Returns total habits for this day and user
  def total_habits_count(user)
    habits_for_user(user).count
  end

  # Returns completion percentage for this day and user
  def completion_percentage(user)
    total = total_habits_count(user)
    total > 0 ? ((completed_habits_count(user).to_f / total) * 100).round : 0
  end
end
