class SetDefaultStreakForHabits < ActiveRecord::Migration[7.2]
  def change
    change_column_default :habits, :streak, from: nil, to: 0
    Habit.where(streak: nil).update_all(streak: 0)
  end
end
