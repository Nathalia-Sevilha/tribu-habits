class AddDefaultColorToHabits < ActiveRecord::Migration[7.2]
  def change
    change_column_default :habits, :color, "F5F5F5"
    Habit.where(color: [ nil, "" ]).update_all(color: "F5F5F5")
  end
end
