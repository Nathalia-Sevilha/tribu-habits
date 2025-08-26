class DayHabit < ApplicationRecord
  belongs_to :habit
  belongs_to :day
end
